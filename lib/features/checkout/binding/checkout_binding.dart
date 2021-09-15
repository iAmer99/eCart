import 'package:dio/dio.dart';
import 'package:ecart/features/checkout/controller/checkout_controller.dart';
import 'package:ecart/features/checkout/repository/checkout_repository.dart';
import 'package:get/get.dart';

class CheckoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckoutController>(() => CheckoutController(CheckoutRepository(Get.find<Dio>(tag: 'dio'))));
  }

}