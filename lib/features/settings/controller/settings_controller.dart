import 'package:ecart/core/remote/dio_util.dart';
import 'package:ecart/core/session_management.dart';
import 'package:ecart/features/shared/localization/myLocales.dart';
import 'package:ecart/features/shared/themes/themes.dart';
import 'package:ecart/routes/routes_names.dart';
import 'package:ecart/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../main.dart';

class SettingsController extends GetxController {

  ThemeMode themeMode = Get.isDarkMode ? Themes.darkMode : Themes.lightMode;
  Locale locale = SessionManagement.isArabic ? MyLocales.arabic : MyLocales.english;
  bool localeChanged = false;
  bool themeChanged = false;

  changeThemeMode(ThemeMode mode){
    themeMode = mode;
    themeChanged = true;
  }
  changeLanguage(Locale lang){
    locale = lang;
    localeChanged = true;
  }

  save(BuildContext context) async{
    if(themeChanged){
      await SessionManagement.setTheme(themeMode == Themes.darkMode);
      await MyApp.setTheme(context, themeMode);
    }
    if(localeChanged){
      await SessionManagement.setLocale(locale == MyLocales.arabic);
      Get.updateLocale(locale);
      DioUtil.setDioAgain();
    }
    showSuccessDialog("settings_changed".tr, onAction: (){
      Get.offAllNamed(AppRoutesNames.bottomBarScreen);
    });
  }

}