import 'package:ecart/features/products/repository/products_repository.dart';
import 'package:ecart/features/shared/models/product.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  final ProductsRepository _repository;

  ProductsController(this._repository);

  RxStatus _status = RxStatus.loading();
  RxStatus get status => _status;
  List<Product> products = [];
  String sorting = "";
  bool isSorting = false;
  int paginationPage = 1 ;
  bool lastPage = false;

  getSorting(int index){
    paginationPage = 1 ;
    isSorting = true;
    lastPage = false;
    switch (index) {
      case 0: {
       if(sorting.isNotEmpty){
         sorting = "";
         products = [];
         isSorting = false;
       }
      }
      break;
      case 1: {
        sorting = "1,name";
      }
      break;
      case 2: {
        sorting = "-1,priceAfterDiscount";
      }
      break;
      case 3: {
        sorting = "1,priceAfterDiscount";
      }
      break;
      default: {
        sorting = "ratingsAverage,ratingsQuantity";
      }
      break;
    }
  }

  getProducts() async{
   if(!_status.isLoadingMore){
     if(products.isEmpty || isSorting){
       _status = RxStatus.loading();
       paginationPage = 1;
       update();
     }else{
       _status = RxStatus.loadingMore();
       update();
     }
     final response = await _repository.getCategoryProducts({
       "category" : Get.arguments.id,
       "sort" : sorting,
       "page" : paginationPage,
     });
     response.fold((error) {
       _status = RxStatus.error(error);
       update();
     }, (products) {
       if (products.isEmpty) {
         if(this.products.isEmpty){
           _status = RxStatus.empty();
           update();
         }else{
           lastPage = true;
           _status = RxStatus.success();
           update();
         }
       }else {
         if(this.products.isEmpty){
           this.products = products;
           _status = RxStatus.success();
           update();
         }else{
           if(isSorting){
             this.products = products;
           }else{
             this.products.addAll(products.where((element) => this.products.every((element2) => element != element2)));
           }
           _status = RxStatus.success();
           update();
         }
       }
     });
   }
   isSorting = false;
  }

  loadNextPage(){
    if(!lastPage && !_status.isLoading && !_status.isLoadingMore){
      paginationPage ++;
    }
  }

  @override
  void onInit() {
    getProducts();
    super.onInit();
  }

}