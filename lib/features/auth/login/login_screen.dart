import 'package:ecart/features/auth/login/controller/login_controller.dart';
import 'package:ecart/features/auth/validators.dart';
import 'package:ecart/features/auth/widgets/authFormField.dart';
import 'package:ecart/routes/routes_names.dart';
import 'package:ecart/utils/helper_functions.dart';
import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailNode = FocusNode();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passwordNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        closeKeyboard(context);
      },
      child: GetBuilder<LoginController>(
        builder: (controller){
          return ModalProgressHUD(
            inAsyncCall: controller.status.isLoading,
            child: Scaffold(
              body: SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.only(
                          top: 5 * heightMultiplier,),
                        child: BackButton(color: Get.theme.primaryColorDark,),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.only(
                            top: 5 * heightMultiplier, start: 6 * widthMultiplier),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Sign in",
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
                                "Sign in to your account to access thousands of products",
                                style: TextStyle(
                                    color: Get.theme.primaryColorDark.withOpacity(0.5)),
                              ),
                              width: 60 * widthMultiplier,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.only(top: 6 * heightMultiplier),
                        child: Form(
                          key: _formKey,
                          child: Column(
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
                                    top: 1.5 * heightMultiplier),
                                child: AuthFormField(
                                    controller: _emailController,
                                    myFocusNode: _emailNode,
                                    nextFocusNode: _passwordNode,
                                    isPassword: false,
                                    label: "Email",
                                    hint: "Enter your email",
                                    myIcon: Icon(Icons.email_rounded),
                                    myValidator: (email) => isValidEmail(email),
                                    keyboardType: TextInputType.emailAddress),
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
                                    top: 1.5 * heightMultiplier),
                                child: AuthFormField(
                                    controller: _passwordController,
                                    myFocusNode: _passwordNode,
                                    isPassword: true,
                                    label: "Password",
                                    hint: "Enter your password",
                                    myIcon: Icon(Icons.lock),
                                    onComplete: (){
                                      closeKeyboard(context);
                                      if(_formKey.currentState!.validate()){
                                        controller.login(email: _emailController.text.trim(), password: _passwordController.text);
                                      }
                                    },
                                    myValidator: (password) => isValidPassword(password),
                                    keyboardType: TextInputType.visiblePassword),
                              ),
                              Align(
                                alignment: AlignmentDirectional.centerEnd,
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text("Forgot password?"),
                                ),
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
                                          controller.login(email: _emailController.text.trim(), password: _passwordController.text);
                                        }
                                      },
                                      child: Text(
                                        "Sign in",
                                        style: TextStyle(fontSize: 3.6 * textMultiplier),
                                      ))),
                              Align(
                                child: TextButton(
                                    onPressed: () {
                                      Get.offAllNamed(AppRoutesNames.registerScreen);
                                    },
                                    child: Text("Don't have an account? Register")),
                                alignment: AlignmentDirectional.centerStart,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
