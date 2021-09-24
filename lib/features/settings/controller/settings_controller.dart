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

  changeThemeMode(ThemeMode mode){
    themeMode = mode;
  }
  changeLanguage(Locale lang){
    locale = lang;
  }

  save(BuildContext context) async{
    await SessionManagement.setTheme(themeMode == Themes.darkMode);
    await MyApp.setTheme(context, themeMode);
    showSuccessDialog("Settings Changed Successfully", onAction: (){
      Get.offAllNamed(AppRoutesNames.bottomBarScreen);
    });
  }

}