import 'package:ecart/features/changePassword/repository/changePassword_repository.dart';
import 'package:ecart/routes/routes_names.dart';
import 'package:ecart/utils/helper_functions.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  final ChangePasswordRepository _repository;

  ChangePasswordController(this._repository);

  RxStatus _status = RxStatus.empty();

  RxStatus get status => _status;

  changePassword(
      String oldPassword, String password, String passwordConfirmation) async {
    _status = RxStatus.loading();
    update();
    final response = await _repository.changePassword(
      {
        "currentPassword": oldPassword,
        "password": password,
        "passwordConfirmation": passwordConfirmation,
      },
    );
    response.fold((error) {
      _status = RxStatus.error(error);
      update();
      showErrorDialog(error);
    }, (success) {
      _status = RxStatus.success();
      update();
      showSuccessDialog(success, onAction: (){
       Get.back();
      });
    });
  }
}
