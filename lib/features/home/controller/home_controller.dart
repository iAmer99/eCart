import 'package:ecart/core/remote/dio_util.dart';
import 'package:ecart/core/session_management.dart';
import 'package:ecart/features/home/repository/home_repository.dart';
import 'package:ecart/features/shared/models/category.dart';
import 'package:ecart/features/shared/models/product.dart';
import 'package:ecart/utils/helper_functions.dart';
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
   await checkInternetConnection().then((internet) async{
     if(internet != null && internet){
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
     }else{
       categoryStatus = RxStatus.error("No Internet Connection");
       update();
     }
   });
  }

  getCheapProducts() async{
    cheapProductStatus = RxStatus.loading();
    update();
   await checkInternetConnection().then((internet) async{
     if(internet != null && internet){
       final response = await _repository.getProducts("/top-5-Cheap?sort=1,priceAfterDiscount");
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
     }else{
       cheapProductStatus = RxStatus.error("No Internet Connection");
       update();
     }
   });
  }

  getPopularProducts() async{
    popularProductStatus = RxStatus.loading();
    update();
    await checkInternetConnection().then((internet) async{
      if(internet != null && internet){
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
      }else{
        popularProductStatus = RxStatus.error("No Internet Connection");
        update();
      }
    });
  }

  Future checkTokenValidity() async{
    final response = await _repository.checkTokenValidity();
    response.fold((error){
      print(error);
      showSnackBar("No Internet Connection");
    }, (res) async{
      await SessionManagement.refreshTokens(accessToken: res.tokens!.accessToken!, refreshToken: res.tokens!.refreshToken!);
      await DioUtil.setDioAgain();
    });
  }

  @override
  void onInit() async{
    if(SessionManagement.isUser){
      if(DateTime.parse(SessionManagement.expiryDate!).isBefore(DateTime.now())){
        await checkTokenValidity();
      }
    }
    getCategories();
    getCheapProducts();
    getPopularProducts();
    super.onInit();
  }
}
