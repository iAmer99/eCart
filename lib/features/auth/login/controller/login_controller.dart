import 'package:ecart/features/auth/login/repository/login_repository.dart';
import 'package:ecart/utils/helper_functions.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final LoginRepository _repository;
  LoginController(this._repository);
  RxStatus status = RxStatus.empty();

  login({required String email, required String password}) async{
    status = RxStatus.loading();
    update();
    final response = await _repository.login({
      "email" : email,
      "password" : password,
    });
    response.fold((error) => showErrorDialog(error), (r) => Get.defaultDialog(title: r));
    status = RxStatus.empty();
    update();
  }
}