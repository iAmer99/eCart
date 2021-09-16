import 'package:ecart/features/orders/repository/orders_repository.dart';
import 'package:get/get.dart';

class OrdersController extends GetxController {
  final OrdersRepository _repository;

  OrdersController(this._repository);
}