import 'package:ecart/routes/routes_names.dart';
import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    Key? key,
    this.node,
    this.onChange,
    this.title,
    this.hideCart,
    this.hideBack = false,
    this.showSettings = false,
  }) : super(key: key);
  final FocusNode? node;
  final Widget? title;
  final Function(String)? onChange;
  final bool? hideCart;
  final bool hideBack;
  final bool showSettings;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (Navigator.canPop(context) &&
            Get.currentRoute != AppRoutesNames.bottomBarScreen &&
            Get.currentRoute != AppRoutesNames.homeScreen)
          if (!hideBack)
            Expanded(
              child: BackButton(
                color: Get.theme.primaryColorDark,
              ),
              flex: 1,
            ),
        Expanded(
          flex: 6,
          child: title == null
              ? Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(heightMultiplier),
                      border: Border.all(
                          color: Get.theme.primaryColorDark.withOpacity(0.1))),
                  alignment: AlignmentDirectional.centerStart,
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutesNames.searchScreen);
                    },
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: IgnorePointer(
                      ignoring: node == null,
                      child: TextField(
                        focusNode: node,
                        onChanged: onChange != null
                            ? (value) => onChange!(value)
                            : null,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "What are you looking for?",
                            hintStyle: TextStyle(
                              color:
                                  Get.theme.primaryColorDark.withOpacity(0.7),
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color:
                                  Get.theme.primaryColorDark.withOpacity(0.7),
                            )),
                      ),
                    ),
                  ),
                )
              : Center(
                  child: title,
                ),
        ),
        hideCart == null || hideCart == false
            ? Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutesNames.cartScreen);
                  },
                  child: SvgPicture.asset(
                    "assets/svg/cart.svg",
                    color: Get.theme.primaryColor,
                    height: 8 * imageSizeMultiplier,
                  ),
                ))
            : showSettings
                ? Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: (){
                        Get.toNamed(AppRoutesNames.settingsScreen);
                      },
                      child: Icon(
                        Icons.settings,
                        color: Get.theme.primaryColorDark.withOpacity(0.7),
                        size: 8 * imageSizeMultiplier,
                      ),
                    ),
                  )
                : Expanded(
                    flex: 1,
                    child: Container(
                      height: 8 * imageSizeMultiplier,
                      width: 8 * imageSizeMultiplier,
                      color: Colors.transparent,
                    ),
                  ),
      ],
    );
  }
}
