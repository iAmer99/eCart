import 'package:ecart/features/categories/repository/categories_repository.dart';
import 'package:ecart/features/shared/models/category.dart';
import 'package:ecart/utils/helper_functions.dart';
import 'package:get/get.dart';

class CategoriesController extends GetxController{
  final CategoriesRepository _repository;

  CategoriesController(this._repository);

  RxStatus categoryStatus = RxStatus.loading();
  List<Category>? categories;

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

  @override
  void onInit() {
    getCategories();
    super.onInit();
  }

}