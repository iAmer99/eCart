import 'package:dio/dio.dart';
import 'package:ecart/features/cart/controller/cart_controller.dart';
import 'package:ecart/features/cart/repository/cart_repository.dart';
import 'package:get/get.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartController>(() => CartController(CartRepository(Get.find<Dio>(tag: 'dio'))));
  }

}