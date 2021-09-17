import 'package:ecart/features/orders/repository/models/order.dart';
import 'package:ecart/features/orders/repository/orders_repository.dart';
import 'package:get/get.dart';

class OrdersController extends GetxController {
  final OrdersRepository _repository;

  OrdersController(this._repository);

  RxStatus _status = RxStatus.loading();
  RxStatus get status => _status;
  int paginationPage = 1 ;
  bool lastPage = false;
  List<Order> orders = [];

  getOrders() async{
    if(!_status.isLoadingMore){
      if (orders.isNotEmpty) {
        _status = RxStatus.loadingMore();
        update();
      } else {
        _status = RxStatus.loading();
        paginationPage = 1;
        update();
      }
      final response = await _repository.getOrders({"page" : paginationPage});
      response.fold((error){
        _status = RxStatus.error(error);
        update();
      }, (data){
        if (data.isEmpty) {
          if (orders.isEmpty) {
            _status = RxStatus.empty();
            lastPage = true;
            update();
          } else {
            _status = RxStatus.success();
            lastPage = true;
            update();
          }
        } else {
          if (orders.isEmpty) {
            orders = data;
            _status = RxStatus.success();
            update();
          } else {
            this.orders.addAll(data.where(
                    (comingOrder) => this.orders.every((existingOrder) {
                  return comingOrder != existingOrder;
                })));
            _status = RxStatus.success();
            update();
          }
        }
      });
    }
  }

  loadNextPage(){
    if (!lastPage && !_status.isLoading && !_status.isLoadingMore) {
      paginationPage++;
    }
  }

  @override
  void onInit() {
    getOrders();
    super.onInit();
  }
}