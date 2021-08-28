import 'package:dio/dio.dart';
import 'package:ecart/features/forgotPassword/controller/forgotPassword_controller.dart';
import 'package:ecart/features/forgotPassword/repository/forgotPassword_repository.dart';
import 'package:get/get.dart';

class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController(ForgotPasswordRepository(Get.find<Dio>(tag: 'dio'))));
  }

}