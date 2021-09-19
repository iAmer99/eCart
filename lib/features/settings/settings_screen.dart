import 'package:ecart/features/settings/widget/languageDropDownMenu.dart';
import 'package:ecart/features/settings/widget/themeDropDownMenu.dart';
import 'package:ecart/features/shared/widgets/appBar.dart';
import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
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
                  "Settings",
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
                          onPressed: () {},
                          child: Text(
                            "Save",
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
