import 'package:dio/dio.dart';
import 'package:ecart/features/update_account/controller/account_controller.dart';
import 'package:ecart/features/update_account/repository/account_repository.dart';
import 'package:get/get.dart';

class AccountBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AccountController>(() => AccountController(AccountRepository(Get.find<Dio>(tag: 'dio'))));
  }

}