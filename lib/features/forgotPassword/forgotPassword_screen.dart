import 'package:ecart/features/auth/validators.dart' as validator;
import 'package:ecart/features/auth/widgets/authFormField.dart';
import 'package:ecart/features/forgotPassword/controller/forgotPassword_controller.dart';
import 'package:ecart/utils/helper_functions.dart';
import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);
  static GlobalKey<FormState> _firstKey = GlobalKey<FormState>();
  static GlobalKey<FormState> _secondKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailNode = FocusNode();
  final TextEditingController _codeController = TextEditingController();
  final FocusNode _codeNode = FocusNode();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passwordNode = FocusNode();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FocusNode _confirmPasswordNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotPasswordController>(builder: (controller){
      return ModalProgressHUD(
        inAsyncCall: controller.status.isLoading,
        child: GestureDetector(
          onTap: (){
            closeKeyboard(context);
          },
          child: Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GetBuilder<ForgotPasswordController>(builder: (controller) {
                      return Padding(
                        padding: EdgeInsetsDirectional.only(
                          top: 5 * heightMultiplier,
                        ),
                        child: BackButton(
                          color: Get.theme.primaryColorDark,
                          onPressed: () {
                            if (controller.index == 0) {
                              Get.back();
                            } else {
                              controller.getBack();
                            }
                          },
                        ),
                      );
                    }),
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                          top: 5 * heightMultiplier, start: 6 * widthMultiplier),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Forgot password?",
                            style: TextStyle(
                                color: Get.theme.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 4 * textMultiplier),
                          ),
                          SizedBox(
                            height: 1.2 * heightMultiplier,
                          ),
                          Container(
                            child: Text(
                              "Reset your password to get back to your account",
                              style: TextStyle(
                                  color: Get.theme.primaryColorDark.withOpacity(0.5)),
                            ),
                            width: 60 * widthMultiplier,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(top: 2 * heightMultiplier),
                      child: Align(
                        alignment: AlignmentDirectional.center,
                        child: SvgPicture.asset(
                          "assets/svg/forgot_password.svg",
                          height: 35 * imageSizeMultiplier,
                        ),
                      ),
                    ),
                    GetBuilder<ForgotPasswordController>(builder: (controller) {
                      if (controller.index == 0) {
                        return _buildFirstForm(context, controller);
                      } else {
                        return _buildSecondForm(context, controller);
                      }
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Padding _buildSecondForm(
      BuildContext context, ForgotPasswordController controller) {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 4 * heightMultiplier),
      child: Form(
        key: _secondKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Get.theme.accentColor,
                borderRadius: BorderRadius.circular(1.5 * heightMultiplier),
              ),
              margin: EdgeInsetsDirectional.only(
                  end: 6 * widthMultiplier,
                  start: 6 * widthMultiplier,
                  bottom: 1.5 * heightMultiplier),
              child: AuthFormField(
                  controller: _codeController,
                  myFocusNode: _codeNode,
                  nextFocusNode: _passwordNode,
                  isPassword: false,
                  label: "Code",
                  hint: "Enter code you received",
                  myIcon: Icon(Icons.security),
                  myValidator: (code) => validator.isValidCode(code),
                  keyboardType: TextInputType.text),
            ),
            Container(
              decoration: BoxDecoration(
                color: Get.theme.accentColor,
                borderRadius: BorderRadius.circular(1.5 * heightMultiplier),
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
                  label: "New Password",
                  hint: "Enter new password",
                  myIcon: Icon(Icons.lock),
                  myValidator: (password) =>
                      validator.isValidPassword(password),
                  keyboardType: TextInputType.visiblePassword),
            ),
            Container(
              decoration: BoxDecoration(
                color: Get.theme.accentColor,
                borderRadius: BorderRadius.circular(1.5 * heightMultiplier),
              ),
              margin: EdgeInsetsDirectional.only(
                end: 6 * widthMultiplier,
                start: 6 * widthMultiplier,
              ),
              child: AuthFormField(
                  controller: _confirmPasswordController,
                  myFocusNode: _confirmPasswordNode,
                  onComplete: () {
                    closeKeyboard(context);
                    if (_secondKey.currentState!.validate()) {
                      controller.resetPassword(
                        _codeController.text,
                        _passwordController.text,
                        _confirmPasswordController.text,
                      );
                    }
                  },
                  isPassword: true,
                  label: "Confirm Password",
                  hint: "Enter password again",
                  myIcon: Icon(Icons.password),
                  myValidator: (confirmPassword) => validator.confirmPassword(
                      _passwordController.text, confirmPassword),
                  keyboardType: TextInputType.visiblePassword),
            ),
            Align(
              child: TextButton(
                  onPressed: () {
                    controller.getBack();
                  }, child: Text("Didn't receive code?")),
              alignment: AlignmentDirectional.centerStart,
            ),
            Container(
                width: 75 * widthMultiplier,
                height: 8 * heightMultiplier,
                margin:
                    EdgeInsetsDirectional.only(bottom: 1 * heightMultiplier),
                child: ElevatedButton(
                    onPressed: () {
                      closeKeyboard(context);
                      if (_secondKey.currentState!.validate()) {
                        controller.resetPassword(
                          _codeController.text,
                          _passwordController.text,
                          _confirmPasswordController.text,
                        );
                      }
                    },
                    child: Text(
                      "Save",
                      style: TextStyle(fontSize: 3.6 * textMultiplier),
                    ))),
          ],
        ),
      ),
    );
  }

  Padding _buildFirstForm(
      BuildContext context, ForgotPasswordController controller) {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 4 * heightMultiplier),
      child: Form(
        key: _firstKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Get.theme.accentColor,
                borderRadius: BorderRadius.circular(1.5 * heightMultiplier),
              ),
              margin: EdgeInsetsDirectional.only(
                  end: 6 * widthMultiplier,
                  start: 6 * widthMultiplier,
                  bottom: 4 * heightMultiplier),
              child: AuthFormField(
                  controller: _emailController,
                  myFocusNode: _emailNode,
                  isPassword: false,
                  label: "Email",
                  hint: "Enter your email",
                  onComplete: () {
                    closeKeyboard(context);
                    if (_firstKey.currentState!.validate()) {
                      controller.forgotPassword(_emailController.text.trim());
                    }
                  },
                  myIcon: Icon(Icons.email_rounded),
                  myValidator: (email) => validator.isValidEmail(email),
                  keyboardType: TextInputType.emailAddress),
            ),
            Container(
                width: 75 * widthMultiplier,
                height: 8 * heightMultiplier,
                margin:
                    EdgeInsetsDirectional.only(bottom: 1 * heightMultiplier),
                child: ElevatedButton(
                    onPressed: () {
                      closeKeyboard(context);
                      if (_firstKey.currentState!.validate()) {
                        controller.forgotPassword(_emailController.text.trim());
                      }
                    },
                    child: Text(
                      "Send Code",
                      style: TextStyle(fontSize: 3.6 * textMultiplier),
                    ))),
          ],
        ),
      ),
    );
  }
}
