import 'package:ecart/core/session_management.dart';
import 'package:ecart/features/settings/controller/settings_controller.dart';
import 'package:ecart/features/settings/widget/myDropDown.dart';
import 'package:ecart/features/shared/localization/myLocales.dart';
import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LanguageDropDownMenu extends StatefulWidget {
  const LanguageDropDownMenu({Key? key}) : super(key: key);

  @override
  _LanguageDropDownMenuState createState() => _LanguageDropDownMenuState();
}

class _LanguageDropDownMenuState extends State<LanguageDropDownMenu> {
  Locale locale = SessionManagement.isArabic ? MyLocales.arabic : MyLocales.english;
  final SettingsController _controller = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return MyDropDownMenu(
        child: DropdownButtonHideUnderline(
          child: DropdownButton<Locale>(
            isExpanded: true,
            items: [
              DropdownMenuItem<Locale>(
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svg/en.svg',
                      height: 6 * imageSizeMultiplier,
                    ),
                    SizedBox(
                      width: widthMultiplier,
                    ),
                    Text(
                      "English",
                      style: TextStyle(
                        fontSize: 2.2 * textMultiplier,
                      ),
                    ),
                  ],
                ),
                value: MyLocales.english,
              ),
              DropdownMenuItem<Locale>(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/svg/ar.svg',
                        height: 6 * imageSizeMultiplier,
                      ),
                      SizedBox(
                        width: widthMultiplier,
                      ),
                      Text(
                        "العربيه",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 2.2 * textMultiplier,
                        ),
                      ),
                    ],
                  ),
                ),
                value: MyLocales.arabic,
              ),
            ],
            value: locale,
            onChanged: (value) {
              setState(() {
                locale = value!;
              });
             if(value != null) _controller.changeLanguage(value);
            },
            dropdownColor: Get.theme.canvasColor,
          ),
        ));
  }
}
