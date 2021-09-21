import 'package:ecart/features/changePassword/controller/changePassword_controller.dart';
import 'package:ecart/features/changePassword/repository/changePassword_repository.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class ChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangePasswordController>(() => ChangePasswordController(
        ChangePasswordRepository(Get.find<Dio>(tag: 'dio'))));
  }
}
