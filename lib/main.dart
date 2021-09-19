import 'package:ecart/core/remote/dio_util.dart';
import 'package:ecart/core/session_management.dart';
import 'package:ecart/features/shared/localization/myLocales.dart';
import 'package:ecart/features/shared/localization/texts.dart';
import 'package:ecart/features/shared/themes/themes.dart';
import 'package:ecart/routes/router.dart';
import 'package:ecart/routes/routes_names.dart';
import 'package:ecart/utils/colors.dart';
import 'package:ecart/utils/helper_functions.dart';
import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SessionManagement.init();
  DioUtil.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return OrientationBuilder(builder: (context, orientation) {
          init(constraints, orientation);
          changeStatusBarColor();
          return GetMaterialApp(
            title: 'eCart',
            debugShowCheckedModeBanner: false,
            theme: Themes.lightTheme,
            locale: SessionManagement.isArabic ? MyLocales.arabic : MyLocales.english,
            translations: Texts(),
            getPages: AppRouter.pages,
            initialRoute: AppRoutesNames.splashScreen,
          );
        });
      },
    );
  }
}
