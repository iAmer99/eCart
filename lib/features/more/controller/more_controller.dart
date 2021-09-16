import 'package:ecart/core/remote/dio_util.dart';
import 'package:ecart/core/session_management.dart';
import 'package:ecart/routes/routes_names.dart';
import 'package:get/get.dart';

class MoreController extends GetxController {

  logout(){
    SessionManagement.logout();
    DioUtil.setDioAgain();
    Get.offNamed(AppRoutesNames.loginScreen);
  }
}