import 'package:ecart/features/settings/controller/settings_controller.dart';
import 'package:ecart/features/settings/widget/myDropDown.dart';
import 'package:ecart/features/shared/themes/themes.dart';
import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ThemeDropDownMenu extends StatefulWidget {
  const ThemeDropDownMenu({Key? key}) : super(key: key);

  @override
  _ThemeDropDownMenuState createState() => _ThemeDropDownMenuState();
}

class _ThemeDropDownMenuState extends State<ThemeDropDownMenu> {
  ThemeMode mode = Get.isDarkMode ? Themes.darkMode : Themes.lightMode;
  final SettingsController _controller = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return MyDropDownMenu(
        child: DropdownButtonHideUnderline(
      child: DropdownButton<ThemeMode>(
        isExpanded: true,
        items: [
          DropdownMenuItem<ThemeMode>(
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/svg/light.svg',
                  height: 7 * imageSizeMultiplier,
                ),
                SizedBox(
                  width: widthMultiplier,
                ),
                Text(
                  "Light",
                  style: TextStyle(
                    fontSize: 2.2 * textMultiplier,
                  ),
                ),
              ],
            ),
            value: Themes.lightMode,
          ),
          DropdownMenuItem<ThemeMode>(
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/svg/dark.svg',
                  height: 6 * imageSizeMultiplier,
                ),
                SizedBox(
                  width: widthMultiplier,
                ),
                Text(
                  "Dark",
                  style: TextStyle(
                    fontSize: 2.2 * textMultiplier,
                  ),
                ),
              ],
            ),
            value: Themes.darkMode,
          ),
        ],
        value: mode,
        onChanged: (value) {
          setState(() {
            mode = value!;
          });
          if(value != null) _controller.changeThemeMode(value);
        },
        dropdownColor: Get.theme.canvasColor,
      ),
    ));
  }
}
