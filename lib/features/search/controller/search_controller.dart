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
    if(products.isEmpty){
      _status = RxStatus.loading();
      update();
    }else{
      _status = RxStatus.loadingMore();
    }
    isInitial = false;
    update();
    final response = await _repository.search({
      "filter" : input,
      "sort" : sorting,
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
}