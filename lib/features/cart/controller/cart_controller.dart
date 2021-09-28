import 'package:ecart/core/session_management.dart';
import 'package:ecart/features/cart/repository/cart_repository.dart';
import 'package:ecart/features/cart/repository/model/cart_item.dart';
import 'package:ecart/features/shared/models/cart.dart';
import 'package:ecart/features/shared/models/product.dart';
import 'package:ecart/usecase/cart_usecase.dart';
import 'package:ecart/utils/helper_functions.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepository _repository;

  CartController(this._repository);

  late Cart cart;
  late num _totalPrice;
  RxStatus _status = RxStatus.loading();

  RxStatus get status => _status;

  num get totalPrice {
    num discount = (_totalPrice * SessionManagement.discount) / 100;
    return _totalPrice - discount;
  }

  RxStatus _discountStatus = RxStatus.empty();

  RxStatus get discountStatus => _discountStatus;

  String code = SessionManagement.discountCode ?? "";

  getCart() async {
    _status = RxStatus.loading();
    update();
    if (SessionManagement.discountCode == null) {
      await checkDiscount();
    }
    final response = await _repository.getCartItems();
    response.fold((error) {
      _status = RxStatus.error(error);
      update();
    }, (cart) {
      if (cart.cartItems!.isEmpty) {
        this.cart = cart;
        _totalPrice = 0;
        _status = RxStatus.empty();
        update();
      } else {
        this.cart = cart;
        _totalPrice = cart.totalPrice!;
        _status = RxStatus.success();
        update();
      }
    });
  }

  _localChange(bool increase, String id, Color color, Size size) {
    CartItem selectedItem = cart.cartItems!.firstWhere((item) =>
        item.product!.id == id &&
        item.selectedColor == color &&
        item.selectedSize == size);
    num selectedItemQuantity = selectedItem.totalProductQuantity!;
    num selectedItemPrice =
        selectedItem.totalProductPrice! / selectedItemQuantity;
    if (increase) {
      selectedItem.totalProductQuantitySetter = selectedItemQuantity + 1;
      selectedItem.totalProductPriceSetter =
          selectedItem.totalProductPrice! + selectedItemPrice;
      _totalPrice = _totalPrice + selectedItemPrice;
      update();
    } else {
      selectedItem.totalProductQuantitySetter =
          selectedItem.totalProductQuantity! - 1;
      selectedItem.totalProductPriceSetter =
          selectedItem.totalProductPrice! - selectedItemPrice;
      _totalPrice = _totalPrice - selectedItemPrice;
      update();
    }
  }

  _onError(bool increase, String id, Color color, Size size) {
    CartItem selectedItem = cart.cartItems!.firstWhere((item) =>
        item.product!.id == id &&
        item.selectedColor == color &&
        item.selectedSize == size);
    num selectedItemQuantity = selectedItem.totalProductQuantity!;
    num selectedItemPrice =
        selectedItem.totalProductPrice! / selectedItemQuantity;
    if (increase) {
      selectedItem.totalProductQuantitySetter =
          selectedItem.totalProductQuantity! - 1;
      selectedItem.totalProductPriceSetter =
          selectedItem.totalProductPrice! - selectedItemPrice;
      _totalPrice = _totalPrice - selectedItemPrice;
      update();
    } else {
      selectedItem.totalProductQuantitySetter =
          selectedItem.totalProductQuantity! + 1;
      selectedItem.totalProductPriceSetter =
          selectedItem.totalProductPrice! + selectedItemPrice;
      _totalPrice = _totalPrice + selectedItemPrice;
      update();
    }
  }

  increase(String id, Color selectedColor, Size selectedSize) async {
    _localChange(true, id, selectedColor, selectedSize);
    final response =
        await CartUseCase.increase(id, selectedColor.id!, selectedSize.id!);
    response.fold((error) {
      _onError(true, id, selectedColor, selectedSize);
      showSnackBar(error);
    }, (res) {
      if (!res) {
        _onError(true, id, selectedColor, selectedSize);
        showSnackBar("unknown_error".tr);
      }
    });
  }

  decrease(
      String id, num quantity, Color selectedColor, Size selectedSize) async {
    if (quantity > 1) {
      _localChange(false, id, selectedColor, selectedSize);
      final response =
          await CartUseCase.decrease(id, selectedColor.id!, selectedSize.id!);
      response.fold((error) {
        _onError(false, id, selectedColor, selectedSize);
        update();
        showSnackBar(error);
      }, (res) {
        if (!res) {
          _onError(false, id, selectedColor, selectedSize);
          showSnackBar("unknown_error".tr);
        }
      });
    } else {
      removeFromCart(id, selectedColor.id!, selectedSize.id!);
    }
  }

  removeFromCart(
      String id, String selectedColorID, String selectedSizeID) async {
    CartItem selectedItem = cart.cartItems!.firstWhere((element) =>
        element.product!.id == id &&
        element.selectedColor!.id == selectedColorID &&
        element.selectedSize!.id == selectedSizeID);
    int index = cart.cartItems!.indexOf(selectedItem);
    num selectedItemPrice = selectedItem.totalProductPrice!;
    cart.cartItems!.removeAt(index);
    _totalPrice = _totalPrice - selectedItemPrice;
    update();
    final response =
        await CartUseCase.removeFromCart(id, selectedColorID, selectedSizeID);
    response.fold((error) {
      cart.cartItems!.insert(index, selectedItem);
      _totalPrice = _totalPrice + selectedItemPrice;
      update();
      showSnackBar(error);
    }, (res) {
      if (!res) {
        cart.cartItems!.insert(index, selectedItem);
        _totalPrice = _totalPrice + selectedItemPrice;
        update();
        showSnackBar("unknown_error".tr);
      }
    });
    if (cart.cartItems!.isEmpty) {
      _status = RxStatus.empty();
      update();
    }
  }

  verifyDiscount(String code) async {
    _discountStatus = RxStatus.loading();
    update();
    if (code.isEmpty) {
      _discountStatus = RxStatus.error("empty_code".tr);
      update();
    } else {
      final response = await _repository.verifyDiscount(code);
      response.fold((error) {
        _discountStatus = RxStatus.error(error);
        update();
      }, (discount) {
        SessionManagement.setNewDiscount(discount, code);
        _discountStatus = RxStatus.success();
        update();
      });
    }
  }

  deleteDiscount() async {
    String? code = SessionManagement.discountCode;
    num discount = SessionManagement.discount;
    this.code = "";
    SessionManagement.resetDiscount();
    update();
    final response = await _repository.cancelDiscount();
    response.fold((error) {
      SessionManagement.setNewDiscount(discount, code!);
      this.code = code;
      showSnackBar(error);
      update();
    }, (response) {
      if (!response) {
        SessionManagement.setNewDiscount(discount, code!);
        this.code = code;
        showSnackBar("unknown_error".tr);
        update();
      }
    });
  }

  onCodeChange(String code) {
    this.code = code;
    update();
  }

  checkDiscount() async {
    final response = await _repository.checkDiscount();
    response.fold((_) => null, (discount) {
      SessionManagement.setNewDiscount(discount.off, discount.code);
    });
  }

  @override
  void onInit() {
    getCart();
    super.onInit();
  }
}
