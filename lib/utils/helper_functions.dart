import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void changeStatusBarColor() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ),
  );
}

void closeKeyboard(BuildContext context) => FocusScope.of(context).unfocus();
