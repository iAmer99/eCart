import 'package:ecart/features/splash/splash_screen.dart';
import 'package:ecart/routes/router.dart';
import 'package:ecart/routes/routes_names.dart';
import 'package:ecart/utils/colors.dart';
import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return OrientationBuilder(builder: (context, orientation) {
          init(constraints, orientation);
          return GetMaterialApp(
            title: 'eCart',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primaryColor: mainColor,
                primaryColorLight: Colors.white,
                primaryColorDark: Colors.black,
                canvasColor: Colors.white),
            getPages: AppRouter.pages,
            initialRoute: AppRoutesNames.splashScreen,
          );
        });
      },
    );
  }
}
