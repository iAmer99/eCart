import 'package:ecart/core/remote/dio_util.dart';
import 'package:ecart/core/session_management.dart';
import 'package:ecart/features/auth/login/repository/login_repository.dart';
import 'package:ecart/routes/routes_names.dart';
import 'package:ecart/utils/helper_functions.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final LoginRepository _repository;

  LoginController(this._repository);

  RxStatus status = RxStatus.empty();

  login({required String email, required String password}) async {
    status = RxStatus.loading();
    update();
    await checkInternetConnection().then((internet) async {
      if (internet != null && internet) {
        final response = await _repository.login({
          "email": email,
          "password": password,
        });
        response.fold((error) {
          status = RxStatus.error(error);
          update();
          showErrorDialog(error);
        }, (response) {
          SessionManagement.createUserSession(
              accessToken: response.tokens!.accessToken!,
              refreshToken: response.tokens!.refreshToken!,
              name: response.user!.name!,
              email: response.user!.email!,
              id: response.user!.id!,
              phone: response.user!.phone,
              image: response.user!.profileImage!);
          DioUtil.setDioAgain();
          status = RxStatus.success();
          update();
          Get.offAllNamed(AppRoutesNames.bottomBarScreen);
        });
      } else {
        status = RxStatus.error();
        update();
        showSnackBar("No Internet Connection");
      }
    });
  }
}
