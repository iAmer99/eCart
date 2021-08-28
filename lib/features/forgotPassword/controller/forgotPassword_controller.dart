import 'package:ecart/features/forgotPassword/repository/forgotPassword_repository.dart';
import 'package:ecart/routes/routes_names.dart';
import 'package:ecart/utils/helper_functions.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final ForgotPasswordRepository _repository;

  ForgotPasswordController(this._repository);

  int index = 0;

  RxStatus status = RxStatus.empty();

  getBack() {
    index = 0;
    update();
  }

  forgotPassword(String email) async {
    status = RxStatus.loading();
    update();
    final response = await _repository.forgotPassword({"email": email});
    response.fold((error) {
      status = RxStatus.error(error);
      update();
      showErrorDialog(error);
    }, (success) {
      status = RxStatus.success();
      showSuccessDialog(success);
      index = 1;
      update();
    });
  }

  resetPassword(
      String code, String password, String passwordConfirmation) async {
    status = RxStatus.loading();
    update();
    final response = await _repository.resetPassword(
        {"password": password, "passwordConfirmation": passwordConfirmation},
        code);
    response.fold((error) {
      status = RxStatus.error(error);
      update();
      showErrorDialog(error);
    }, (success) {
      status = RxStatus.success();
      update();
      showSuccessDialog(success);
      Get.offAllNamed(AppRoutesNames.loginScreen);
    });
  }
}
