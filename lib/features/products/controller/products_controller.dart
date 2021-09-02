import 'package:ecart/features/products/repository/products_repository.dart';
import 'package:ecart/features/shared/models/product.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  final ProductsRepository _repository;

  ProductsController(this._repository);

  RxStatus _status = RxStatus.loading();
  RxStatus get status => _status;
  List<Product> products = [];
  String sorting = "ratingsAverage,ratingsQuantity";

  getSorting(int index){
    switch (index) {
      case 0: {
        sorting = "ratingsAverage,ratingsQuantity";
      }
      break;
      case 1: {
        sorting = "1,name";
      }
      break;
      case 2: {
        sorting = "-1,price";
      }
      break;
      case 3: {
        sorting = "1,price";
      }
      break;
      default: {
        sorting = "ratingsAverage,ratingsQuantity";
      }
      break;
    }
  }

  getProducts() async{
    _status = RxStatus.loading();
    update();
    final response = await _repository.getCategoryProducts({
      "category" : Get.arguments.id,
      "sort" : sorting
    });
    response.fold((error) {
      _status = RxStatus.error(error);
      update();
    }, (products) {
      this.products = products;
      if (products.isEmpty) {
        _status = RxStatus.empty();
        update();
      } else {
        _status = RxStatus.success();
        update();
      }
    });
  }

  @override
  void onInit() {
    getProducts();
    super.onInit();
  }

}