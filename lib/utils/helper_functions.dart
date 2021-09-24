import 'dart:io';

import 'package:ecart/core/session_management.dart';
import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

void changeStatusBarColor() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
        statusBarIconBrightness:
            SessionManagement.isDark ? Brightness.light : Brightness.dark,
        statusBarColor: Colors.transparent),
  );
}

void closeKeyboard(BuildContext context) => FocusScope.of(context).unfocus();

showErrorDialog(String error) {
  Get.dialog(AlertDialog(
    title: Text(
      "Error Occurred",
      style: TextStyle(
        color: Get.theme.primaryColorDark,
      ),
    ),
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

showSuccessDialog(String msg, {Function? onAction}) {
  Get.dialog(
    AlertDialog(
      title: Text(
        "Success",
        style: TextStyle(
          color: Get.theme.primaryColorDark,
        ),
      ),
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
              fontSize: 2.2 * textMultiplier,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Get.back();
              if (onAction != null) onAction();
            },
            child: Text("Okay"))
      ],
    ),
    barrierDismissible: onAction == null,
  );
}

Future<bool?> checkInternetConnection() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
  } on SocketException catch (_) {
    return false;
  }
}

showSnackBar(String msg) {
  Get.rawSnackbar(
    messageText: Text(
      msg,
      style: TextStyle(color: Get.theme.primaryColorDark),
    ),
    backgroundColor: Get.theme.canvasColor,
  );
}
