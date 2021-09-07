import 'package:ecart/core/remote/dio_util.dart';
import 'package:ecart/core/session_management.dart';
import 'package:ecart/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: (){
            SessionManagement.logout();
            DioUtil.setDioAgain();
            Get.offNamed(AppRoutesNames.loginScreen);
          },
          child: Text("Logout"),
        ),
      ),
    );
  }
}
