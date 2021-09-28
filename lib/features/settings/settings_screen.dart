import 'package:ecart/core/session_management.dart';
import 'package:ecart/features/settings/controller/settings_controller.dart';
import 'package:ecart/features/settings/widget/languageDropDownMenu.dart';
import 'package:ecart/features/settings/widget/themeDropDownMenu.dart';
import 'package:ecart/features/shared/themes/themes.dart';
import 'package:ecart/features/shared/widgets/appBar.dart';
import 'package:ecart/main.dart';
import 'package:ecart/routes/routes_names.dart';
import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4 * widthMultiplier),
          child: Column(
            children: [
              SizedBox(
                height: Get.statusBarHeight * 0.4,
              ),
              MyAppBar(
                hideCart: true,
                title: Text(
                  "settings".tr,
                  style: TextStyle(
                    color: Get.theme.primaryColorDark,
                    fontSize: 2.5 * textMultiplier,
                  ),
                ),
              ),
              SizedBox(
                height: 3 * heightMultiplier,
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ThemeDropDownMenu(),
                      LanguageDropDownMenu(),
                      Container(
                        width: 75 * widthMultiplier,
                        height: 8 * heightMultiplier,
                        margin: EdgeInsets.only(bottom: 2 * heightMultiplier),
                        child: ElevatedButton(
                          onPressed: () async{
                            controller.save(context);
                          },
                          child: Text(
                            "save".tr,
                            style: TextStyle(fontSize: 3.6 * textMultiplier),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
