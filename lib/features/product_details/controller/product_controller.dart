import 'package:ecart/features/product_details/repository/model/productInCart.dart';
import 'package:ecart/features/product_details/repository/product_repository.dart';
import 'package:ecart/features/shared/models/product.dart';
import 'package:ecart/usecase/cart_usecase.dart';
import 'package:ecart/usecase/favourites_usecase.dart';
import 'package:ecart/utils/helper_functions.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final ProductRepository _repository;

  ProductController(this._repository);

  Product product = Get.arguments;
  RxStatus _status = RxStatus.loading();
  List<String> img = [];
  int index = 0;
  bool isFavourite = false;
  RxBool addedToCart = false.obs;
  late Size _selectedSize;
  late Color _selectedColor;
  List<ProductInCart> cartOfProduct = [];

  RxStatus get status => _status;

  RxInt quantity = 1.obs;

  Size get selectedSize => _selectedSize;
  Color get selectedColor => _selectedColor;

  increase() async {
    quantity++;
    if (addedToCart.isTrue) {
      final response = await CartUseCase.increase(
          product.id!, _selectedColor.id!, _selectedSize.id!);
      response.fold((error) {
        quantity--;
        showSnackBar(error);
      }, (res) {
        if (!res) {
          quantity--;
          showSnackBar("unknown_error".tr);
        } else {
          ProductInCart product =
              _getProductInCart("${_selectedColor.id}" + "${_selectedSize.id}");
          product.quantity = quantity.value;
        }
      });
    }
  }

  decrease() async {
    if (quantity.value != 1) {
      quantity--;
      if (addedToCart.isTrue) {
        final response = await CartUseCase.decrease(
            product.id!, _selectedColor.id!, _selectedSize.id!);
        response.fold((error) {
          quantity++;
          showSnackBar(error);
        }, (res) {
          if (!res) {
            quantity++;
            showSnackBar("unknown_error".tr);
          } else {
            ProductInCart product = _getProductInCart(
                "${_selectedColor.id}" + "${_selectedSize.id}");
            product.quantity = quantity.value;
          }
        });
      }
    }
  }

  getIndex(int index) {
    this.index = index;
    update();
  }

  getImages() {
    img = [
      product.mainImage!,
    ];
    img.addAll(product.images!);
    update();
  }

  checkFavouriteAndCart() async {
    _status = RxStatus.loading();
    update();
    this.isFavourite = await _repository.checkFavourite(product.id!);
    final response = await _repository.checkCart(product.id!);
    response.fold((error) {
      addedToCart.value = false;
      quantity.value = 1;
    }, (data) {
      this.cartOfProduct = data;
      ProductInCart initialProduct = cartOfProduct.first;
      quantity.value = initialProduct.quantity.toInt();
      _selectedColor = initialProduct.selectedColor;
      _selectedSize = initialProduct.selectedSize;
      addedToCart.value = true;
      update();
    });
    _status = RxStatus.success();
    update();
  }

  addToFavourites() async {
    isFavourite = true;
    update();
    final response = await FavouritesUseCase.addToFavourite(product.id!);
    response.fold((error) {
      isFavourite = false;
      update();
      showSnackBar(error);
    }, (res) {
      if (!res) {
        isFavourite = false;
        update();
        showSnackBar("unknown_error".tr);
      }
    });
  }

  removeFromFavourites() async {
    isFavourite = false;
    update();
    final response = await FavouritesUseCase.removeFromFavourites(product.id!);
    response.fold((error) {
      isFavourite = true;
      update();
      showSnackBar(error);
    }, (res) {
      if (!res) {
        isFavourite = true;
        update();
        showSnackBar("unknown_error".tr);
      }
    });
  }

  addToCart() async {
    addedToCart.value = true;
    update();
    final response = await CartUseCase.addToCart(
        product.id!, quantity.value, _selectedColor.id!, _selectedSize.id!);
    response.fold((error) {
      addedToCart.value = false;
      update();
      showSnackBar(error);
    }, (res) {
      if (!res) {
        addedToCart.value = false;
        update();
        showSnackBar("unknown_error".tr);
      } else {
        cartOfProduct.add(ProductInCart(
          selectedColor: _selectedColor,
          selectedSize: _selectedSize,
          id: "${_selectedColor.id}" + "${_selectedSize.id}",
          quantity: quantity.value,
        ));
      }
    });
  }

  refreshProduct() async {
    _status = RxStatus.loading();
    update();
    final response = await _repository.refreshProduct(product.id!);
    response.fold((error) {
      _status = RxStatus.success();
      update();
      showSnackBar(error);
    }, (product) {
      this.product = product;
      _status = RxStatus.success();
      update();
    });
    _selectedSize = product.sizes!.first;
    _selectedColor = product.colors!.first;
  }

  ProductInCart _getProductInCart(String id) {
    ProductInCart product = cartOfProduct.firstWhere((item) => item.id == id);
    return product;
  }

  selectSize(Size size) {
    _selectedSize = size;
    _onChangeColorOrSize();
  }

  _onChangeColorOrSize() {
    if (cartOfProduct.any(
        (item) => item.id == "${_selectedColor.id}" + "${_selectedSize.id}")) {
      ProductInCart product =
          _getProductInCart("${_selectedColor.id}" + "${_selectedSize.id}");
      addedToCart.value = true;
      quantity.value = product.quantity.toInt();
    } else {
      addedToCart.value = false;
      quantity.value = 1;
    }
  }

  selectColor(Color color) {
    _selectedColor = color;
    _onChangeColorOrSize();
  }

  @override
  void onInit() async {
    await refreshProduct();
    getImages();
    checkFavouriteAndCart();
    super.onInit();
  }
}
