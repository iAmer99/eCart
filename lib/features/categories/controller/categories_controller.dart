import 'package:ecart/features/categories/repository/categories_repository.dart';
import 'package:ecart/features/shared/models/category.dart';
import 'package:ecart/utils/helper_functions.dart';
import 'package:get/get.dart';

class CategoriesController extends GetxController {
  final CategoriesRepository _repository;

  CategoriesController(this._repository);

  RxStatus categoryStatus = RxStatus.loading();
  List<Category> categories = [];
  int paginationPage = 1;
  bool lastPage = false;

  getCategories() async {
    if (!categoryStatus.isLoadingMore) {
      if(paginationPage != 1){
        categoryStatus = RxStatus.loadingMore();
      }else{
        categoryStatus = RxStatus.loading();
      }
      update();
      await checkInternetConnection().then((internet) async {
        if (internet != null && internet) {
          final response = await _repository.getCategories({
            "page": paginationPage,
          });
          response.fold(
            (error) {
              categoryStatus = RxStatus.error(error);
              update();
            },
            (categories) {
              if (categories.isNotEmpty) {
                if (this.categories.isEmpty) {
                  this.categories = categories;
                  categoryStatus = RxStatus.success();
                  update();
                } else {
                  this.categories.addAll(categories.where((category1) => this
                      .categories
                      .every((category2) => category1 != category2)));
                  categoryStatus = RxStatus.success();
                  update();
                }
              } else {
               if(this.categories.isEmpty){
                 categoryStatus = RxStatus.empty();
                 update();
               }else{
                 lastPage = true;
                 categoryStatus = RxStatus.success();
                 update();
               }
              }
            },
          );
        } else {
          categoryStatus = RxStatus.error("No Internet Connection");
          update();
        }
      });
    }
  }

  loadNextPage() {
    if (!categoryStatus.isLoadingMore && !lastPage) {
      paginationPage++;
    }
  }

  @override
  void onInit() {
    getCategories();
    super.onInit();
  }
}
