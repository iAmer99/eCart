import 'package:ecart/core/session_management.dart';
import 'package:ecart/features/shared/localization/myLocales.dart';
import 'package:ecart/features/shared/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {


  ThemeMode _themeMode = Get.isDarkMode ? Themes.darkMode : Themes.lightMode;
  Locale _locale = SessionManagement.isArabic ? MyLocales.arabic : MyLocales.english;

  changeThemeMode(ThemeMode mode){
    _themeMode = mode;
  }
  changeLanguage(Locale lang){
    _locale = lang;
  }

}