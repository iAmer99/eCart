import 'package:dio/dio.dart';
import 'package:ecart/features/auth/register/controller/register_controller.dart';
import 'package:ecart/features/auth/register/repository/register_repository.dart';
import 'package:get/get.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(() => RegisterController(RegisterRepository(Get.find<Dio>(tag: 'dio'))));
  }

}