import 'package:dio/dio.dart';
import 'package:ecart/features/orders/controller/orders_controller.dart';
import 'package:ecart/features/orders/repository/orders_repository.dart';
import 'package:get/get.dart';

class OrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrdersController>(
        () => OrdersController(OrdersRepository(Get.find<Dio>(tag: 'dio'))));
  }
}
