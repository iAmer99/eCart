import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    Key? key,
    required this.controller,
    required this.node,
    this.nextNode,
    this.onComplete,
    required this.label,
    this.icon,
    this.validator,
    this.keyboardType,
  }) : super(key: key);
  final TextEditingController controller;
  final FocusNode node;
  final FocusNode? nextNode;
  final Function? onComplete;
  final String label;
  final Widget? icon;
  final Function(String?)? validator;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Get.theme.accentColor,
        borderRadius: BorderRadius.circular(1.5 * heightMultiplier),
      ),
      margin: EdgeInsetsDirectional.only(bottom: 3 * heightMultiplier),
      child: TextFormField(
        controller: controller,
        focusNode: node,
        keyboardType: keyboardType,
        textInputAction:
            onComplete == null ? TextInputAction.next : TextInputAction.done,
        onEditingComplete: () {
          if (onComplete == null) {
            FocusScope.of(context).requestFocus(nextNode);
          } else {
            onComplete!();
          }
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              horizontal: 1 * textMultiplier, vertical: 1.5 * textMultiplier),
          errorStyle: TextStyle(fontSize: 1.9 * textMultiplier),
          labelText: label,
          border: InputBorder.none,
          prefixIcon: icon,
        ),
        validator:
            validator != null ? (String? value) => validator!(value) : null,
      ),
    );
  }
}
