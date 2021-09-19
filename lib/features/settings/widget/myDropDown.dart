import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDropDownMenu extends StatefulWidget {
  const MyDropDownMenu({Key? key, required this.child,}) : super(key: key);
  final Widget child;

  @override
  _MyDropDownMenuState createState() => _MyDropDownMenuState();
}

class _MyDropDownMenuState extends State<MyDropDownMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8 * heightMultiplier,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Get.theme.accentColor,
        borderRadius:
        BorderRadius.circular(1.5 * heightMultiplier),
      ),
      margin: EdgeInsetsDirectional.only(
        bottom: 3 * heightMultiplier,
      ),
      padding: EdgeInsets.symmetric(
          horizontal: 4 * widthMultiplier),
      child: widget.child,
    );
  }

}
