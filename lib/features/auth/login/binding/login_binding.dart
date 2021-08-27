import 'package:dio/dio.dart';
import 'package:ecart/features/auth/login/controller/login_controller.dart';
import 'package:ecart/features/auth/login/repository/login_repository.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
   Get.lazyPut<LoginController>(() => LoginController(LoginRepository(Get.find<Dio>(tag: 'dio'))));
  }

}