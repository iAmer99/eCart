import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

void changeStatusBarColor() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent
    ),
  );
}

void closeKeyboard(BuildContext context) => FocusScope.of(context).unfocus();

showErrorDialog(String error) {
  Get.dialog(AlertDialog(
    title: Text("Error Occurred"),
    backgroundColor: Get.theme.canvasColor,
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          "assets/svg/error.svg",
          height: 30 * imageSizeMultiplier,
        ),
        SizedBox(
          height: 2 * heightMultiplier,
        ),
        Text(
          error,
          style: TextStyle(
              color: Get.theme.primaryColorDark,
              fontSize: 2.2 * textMultiplier),
        ),
      ],
    ),
    actions: [
      TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text("Okay"))
    ],
  ));
}

showSuccessDialog(String msg) {
  Get.dialog(AlertDialog(
    title: Text("Success"),
    backgroundColor: Get.theme.canvasColor,
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          "assets/svg/success.svg",
          height: 30 * imageSizeMultiplier,
        ),
        SizedBox(
          height: 2 * heightMultiplier,
        ),
        Text(
          msg,
          style: TextStyle(
              color: Get.theme.primaryColorDark,
              fontSize: 2.2 * textMultiplier),
        ),
      ],
    ),
    actions: [
      TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text("Okay"))
    ],
  ));
}
