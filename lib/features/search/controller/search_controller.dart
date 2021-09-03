import 'package:ecart/features/search/repository/search_repository.dart';
import 'package:ecart/features/shared/models/product.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  final SearchRepository _repository;

  SearchController(this._repository);

  RxStatus? _status;
  RxStatus? get status => _status;
  List<Product> products = [];
  bool isInitial = true;
  String sorting = "ratingsAverage,ratingsQuantity";
  int paginationPage = 1;
  bool lastPage = false;
  String _lastInput = "";
  bool isSorting = false;

  getSorting(int index){
    paginationPage = 1 ;
    isSorting = true;
    lastPage = false;
    switch (index) {
      case 0: {
        if(sorting != "ratingsAverage,ratingsQuantity"){
          sorting = "ratingsAverage,ratingsQuantity";
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

  search(String input) async{
    if(input.isEmpty){
      products = [];
      paginationPage = 1;
      lastPage = false;
      isInitial = true;
      _lastInput = "";
      _status = null;
      update();
    }else{
      if(_status == null || !_status!.isLoadingMore){
        if(products.isEmpty){
          _status = RxStatus.loading();
          update();
        }else{
          _status = RxStatus.loadingMore();
          update();
        }
        isInitial = false;
        update();
        if(input != _lastInput){
          lastPage = false;
          paginationPage = 1;
          update();
        }
        final response = await _repository.search({
          "filter" : input,
          "sort" : sorting,
          "page" : paginationPage,
        });
        _lastInput = input;
        response.fold((error) {
          _status = RxStatus.error(error);
          update();
        }, (products) {
          if(paginationPage == 1){
            if( products == null || products.isEmpty){
              _status = RxStatus.empty();
              update();
            }else{
              this.products = products;
              _status = RxStatus.success();
              update();
            }
          }else{
            if(products == null || products.isEmpty){
              _status = RxStatus.success();
              lastPage = true;
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
    }
  }

  loadNextPage(){
    if(!lastPage && _status != null && !_status!.isLoading && !_status!.isLoadingMore ){
      paginationPage++;
    }
  }

}