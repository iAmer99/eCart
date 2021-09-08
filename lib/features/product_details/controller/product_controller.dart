import 'package:ecart/features/product_details/repository/product_repository.dart';
import 'package:ecart/features/shared/models/product.dart';
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

  RxStatus get status => _status;

  RxInt quantity = 1.obs;

  increase() async{
    quantity ++;
    if(addedToCart.isTrue){
      final response = await _repository.increase(product.id!);
      response.fold((error) {
        quantity --;
        showSnackBar(error);
      }, (res) {
        if (!res) {
          quantity --;
          showSnackBar("Something went wrong!");
        }
      });
    }
  }
  decrease() async{
    if(quantity.value != 1){
      quantity --;
      if(addedToCart.isTrue){
        final response = await _repository.decrease(product.id!);
        response.fold((error) {
          quantity ++;
          showSnackBar(error);
        }, (res) {
          if (!res) {
            quantity ++;
            showSnackBar("Something went wrong!");
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
    Map<String, Object?> check = await _repository.checkCart(product.id!);
    if(check["exists"] != null && check["exists"] == true){
      this.addedToCart.value = true;
      this.quantity.value = check["quantity"] as int;
    }else{
      this.addedToCart.value = false;
    }
    _status = RxStatus.success();
    update();
  }


  addToFavourites() async{
    isFavourite = true;
    update();
    final response = await _repository.addToFavourite(product.id!);
    response.fold((error) {
      isFavourite = false;
      update();
      showSnackBar(error);
    }, (res) {
      if (!res) {
        isFavourite = false;
        update();
        showSnackBar("Something went wrong!");
      }
    });
  }
  removeFromFavourites() async{
    isFavourite = false;
    update();
    final response = await _repository.removeFromFavourites(product.id!);
    response.fold((error) {
      isFavourite = true;
      update();
      showSnackBar(error);
    }, (res) {
      if (!res) {
        isFavourite = true;
        update();
        showSnackBar("Something went wrong!");
      }
    });
  }

  addToCart() async{
    addedToCart.value = true;
    update();
    final response = await _repository.addToCart(product.id!, quantity.value);
    response.fold((error) {
      addedToCart.value = false;
      update();
      showSnackBar(error);
    }, (res) {
      if (!res) {
        addedToCart.value = false;
        update();
        showSnackBar("Something went wrong!");
      }
    });
  }

  refreshProduct() async {
    _status = RxStatus.loading();
    update();
    final response = await _repository.refreshProduct(product.id!);
    response.fold((error){
      _status = RxStatus.success();
      update();
      showSnackBar(error);
    }, (product){
      this.product = product;
      _status = RxStatus.success();
      update();
    });
  }

  @override
  void onInit() async{
    await refreshProduct();
    getImages();
    checkFavouriteAndCart();
    super.onInit();
  }
}
