import 'package:ecart/features/auth/widgets/authFormField.dart';
import 'package:ecart/features/shared/widgets/appBar.dart';
import 'package:ecart/utils/helper_functions.dart';
import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ecart/features/auth/validators.dart' as validator;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'controller/changePassword_controller.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _oldPasswordController = TextEditingController();
  final FocusNode _oldPasswordNode = FocusNode();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passwordNode = FocusNode();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FocusNode _confirmPasswordNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChangePasswordController>(
      builder: (controller) {
        return ModalProgressHUD(
          inAsyncCall: controller.status.isLoading,
          child: GestureDetector(
            onTap: () {
              closeKeyboard(context);
            },
            child: Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4 * widthMultiplier),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: Get.statusBarHeight * 0.4,
                        ),
                        MyAppBar(
                          hideCart: true,
                          title: Text(
                            "change_password".tr,
                            style: TextStyle(
                              color: Get.theme.primaryColorDark,
                              fontSize: 2.5 * textMultiplier,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 3 * heightMultiplier,
                        ),
                        SvgPicture.asset(
                          "assets/svg/forgot_password.svg",
                          height: 35 * imageSizeMultiplier,
                        ),
                        SizedBox(
                          height: 3 * heightMultiplier,
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Get.theme.accentColor,
                                  borderRadius:
                                      BorderRadius.circular(1.5 * heightMultiplier),
                                ),
                                margin: EdgeInsetsDirectional.only(
                                    end: 6 * widthMultiplier,
                                    start: 6 * widthMultiplier,
                                    bottom: 1.5 * heightMultiplier),
                                child: AuthFormField(
                                    controller: _oldPasswordController,
                                    myFocusNode: _oldPasswordNode,
                                    nextFocusNode: _passwordNode,
                                    isPassword: true,
                                    label: "old_password".tr,
                                    hint: "old_password_hint".tr,
                                    myIcon: Icon(Icons.lock),
                                    myValidator: (password) =>
                                        validator.isValidPassword(password),
                                    keyboardType: TextInputType.visiblePassword),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Get.theme.accentColor,
                                  borderRadius:
                                      BorderRadius.circular(1.5 * heightMultiplier),
                                ),
                                margin: EdgeInsetsDirectional.only(
                                    end: 6 * widthMultiplier,
                                    start: 6 * widthMultiplier,
                                    bottom: 1.5 * heightMultiplier),
                                child: AuthFormField(
                                    controller: _passwordController,
                                    myFocusNode: _passwordNode,
                                    nextFocusNode: _confirmPasswordNode,
                                    isPassword: true,
                                    label: "new_password".tr,
                                    hint: "new_password_hint".tr,
                                    myIcon: Icon(Icons.lock),
                                    myValidator: (password) =>
                                        validator.isValidPassword(password),
                                    keyboardType: TextInputType.visiblePassword),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Get.theme.accentColor,
                                  borderRadius:
                                      BorderRadius.circular(1.5 * heightMultiplier),
                                ),
                                margin: EdgeInsetsDirectional.only(
                                  end: 6 * widthMultiplier,
                                  start: 6 * widthMultiplier,
                                  bottom: 2.5 * heightMultiplier,
                                ),
                                child: AuthFormField(
                                    controller: _confirmPasswordController,
                                    myFocusNode: _confirmPasswordNode,
                                    onComplete: () {
                                      closeKeyboard(context);
                                      if(_formKey.currentState!.validate()){
                                        controller.changePassword(
                                          _oldPasswordController.text,
                                          _passwordController.text,
                                          _confirmPasswordController.text,
                                        );
                                      }
                                    },
                                    isPassword: true,
                                    label: "confirm_password".tr,
                                    hint: "confirm_password_hint".tr,
                                    myIcon: Icon(Icons.password),
                                    myValidator: (confirmPassword) =>
                                        validator.confirmPassword(
                                            _passwordController.text,
                                            confirmPassword),
                                    keyboardType: TextInputType.visiblePassword),
                              ),
                              Container(
                                  width: 75 * widthMultiplier,
                                  height: 8 * heightMultiplier,
                                  margin: EdgeInsetsDirectional.only(
                                      bottom: 1 * heightMultiplier),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        closeKeyboard(context);
                                        if(_formKey.currentState!.validate()){
                                          controller.changePassword(
                                            _oldPasswordController.text,
                                            _passwordController.text,
                                            _confirmPasswordController.text,
                                          );
                                        }
                                      },
                                      child: Text(
                                        "save".tr,
                                        style: TextStyle(
                                            fontSize: 3.6 * textMultiplier),
                                      ))),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
