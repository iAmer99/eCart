import 'package:ecart/features/home/repository/home_repository.dart';
import 'package:ecart/features/shared/models/category.dart';
import 'package:ecart/features/shared/models/product.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final HomeRepository _repository;

  HomeController(this._repository);

  RxStatus categoryStatus = RxStatus.loading();
  List<Category>? categories;

  RxStatus cheapProductStatus = RxStatus.loading();
  List<Product>? cheapProducts;

  RxStatus popularProductStatus = RxStatus.loading();
  List<Product>? popularProducts;

  getCategories() async {
    categoryStatus = RxStatus.loading();
    update();
    final response = await _repository.getCategories();
    response.fold(
      (error) {
        categoryStatus = RxStatus.error(error);
        update();
      },
      (categories) {
        if(categories != null && categories.isNotEmpty){
          this.categories = categories;
          categoryStatus = RxStatus.success();
          update();
        }else{
          categoryStatus = RxStatus.empty();
          update();
        }
      },
    );
  }

  getCheapProducts() async{
    cheapProductStatus = RxStatus.loading();
    update();
    final response = await _repository.getProducts("/top-5-Cheap");
    response.fold(
          (error) {
            cheapProductStatus = RxStatus.error(error);
        update();
      },
          (products) {
        if(products != null && products.isNotEmpty){
          this.cheapProducts = products;
          cheapProductStatus = RxStatus.success();
          update();
        }else{
          cheapProductStatus = RxStatus.empty();
          update();
        }
      },
    );
  }

  getPopularProducts() async{
    popularProductStatus = RxStatus.loading();
    update();
    final response = await _repository.getProducts("?limit=10&sort=ratingsAverage,ratingsQuantity");
    response.fold(
          (error) {
            popularProductStatus = RxStatus.error(error);
        update();
      },
          (products) {
        if(products != null && products.isNotEmpty){
          this.popularProducts = products;
          popularProductStatus = RxStatus.success();
          update();
        }else{
          popularProductStatus = RxStatus.empty();
          update();
        }
      },
    );
  }

  @override
  void onInit() {
    getCategories();
    getCheapProducts();
    getPopularProducts();
    super.onInit();
  }
}
