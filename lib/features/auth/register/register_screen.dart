import 'package:ecart/core/remote/dio_util.dart';
import 'package:ecart/core/session_management.dart';
import 'package:ecart/features/auth/validators.dart';
import 'package:ecart/features/auth/widgets/authFormField.dart';
import 'package:ecart/features/auth/widgets/page_indicator.dart';
import 'package:ecart/routes/routes_names.dart';
import 'package:ecart/utils/colors.dart';
import 'package:ecart/utils/helper_functions.dart';
import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'controller/register_controller.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> _firstKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _secondKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _nameNode = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailNode = FocusNode();
  final TextEditingController _usernameController = TextEditingController();
  final FocusNode _usernameNode = FocusNode();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passwordNode = FocusNode();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FocusNode _confirmPasswordNode = FocusNode();
  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _phoneNode = FocusNode();
  final TextEditingController _addressController = TextEditingController();
  final FocusNode _addressNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        closeKeyboard(context);
      },
      child: GetBuilder<RegisterController>(
        builder: (controller) {
          return ModalProgressHUD(
            inAsyncCall: controller.status.isLoading,
            child: Scaffold(
              body: SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 2 * heightMultiplier),
                        child: GetBuilder<RegisterController>(
                            builder: (controller) {
                          return controller.index != 0
                              ? BackButton(
                                  color: Get.theme.primaryColorDark,
                                  onPressed: () {
                                    controller.goBack();
                                  },
                                )
                              : (Navigator.canPop(context)
                                  ? BackButton(
                                      color: Get.theme.primaryColorDark,
                                    )
                                  : Container());
                        }),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.only(
                            top: 2 * heightMultiplier,
                            start: 6 * widthMultiplier),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "sign_up".tr,
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
                                "sign_up_description".tr,
                                style: TextStyle(
                                    color: Get.theme.primaryColorDark
                                        .withOpacity(0.5)),
                              ),
                              width: 60 * widthMultiplier,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: controller.index == 0
                                ? 1.5 * heightMultiplier
                                : 6 * heightMultiplier),
                        child: Align(
                          child: PageIndicator(index: controller.index),
                          alignment: AlignmentDirectional.center,
                        ),
                      ),
                      if (controller.index == 0)
                        Padding(
                          child: _buildFirstForm(context, controller),
                          padding: EdgeInsetsDirectional.only(
                              top: 2 * heightMultiplier),
                        ),
                      if (controller.index == 1)
                        Padding(
                          child: _buildSecondForm(context, controller),
                          padding: EdgeInsetsDirectional.only(
                              top: 5.5 * heightMultiplier),
                        ),
                      if (controller.index == 2)
                        Padding(
                          child: Align(
                            child: _buildThirdPage(controller),
                            alignment: Alignment.center,
                          ),
                          padding: EdgeInsetsDirectional.only(
                              top: 5.5 * heightMultiplier),
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

  Form _buildFirstForm(BuildContext context, RegisterController controller) {
    return Form(
      key: _firstKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Get.theme.accentColor,
              borderRadius: BorderRadius.circular(1.5 * heightMultiplier),
            ),
            margin: EdgeInsets.symmetric(horizontal: 6 * widthMultiplier),
            child: AuthFormField(
                controller: _nameController,
                myFocusNode: _nameNode,
                nextFocusNode: _emailNode,
                isPassword: false,
                label: "name".tr,
                hint: "name_hint".tr,
                myIcon: Icon(Icons.person),
                myValidator: (name) => isValidName(name!.trim()),
                keyboardType: TextInputType.name),
          ),
          Container(
            decoration: BoxDecoration(
              color: Get.theme.accentColor,
              borderRadius: BorderRadius.circular(1.5 * heightMultiplier),
            ),
            margin: EdgeInsetsDirectional.only(
                end: 6 * widthMultiplier,
                start: 6 * widthMultiplier,
                top: 1.5 * heightMultiplier),
            child: AuthFormField(
                controller: _emailController,
                myFocusNode: _emailNode,
                nextFocusNode: _usernameNode,
                isPassword: false,
                label: "email".tr,
                hint: "email_hint".tr,
                myIcon: Icon(Icons.alternate_email),
                myValidator: (email) => isValidEmail(email!.trim()),
                keyboardType: TextInputType.emailAddress),
          ),
          Container(
            decoration: BoxDecoration(
              color: Get.theme.accentColor,
              borderRadius: BorderRadius.circular(1.5 * heightMultiplier),
            ),
            margin: EdgeInsetsDirectional.only(
                end: 6 * widthMultiplier,
                start: 6 * widthMultiplier,
                top: 1.5 * heightMultiplier),
            child: AuthFormField(
                controller: _usernameController,
                myFocusNode: _usernameNode,
                nextFocusNode: _passwordNode,
                isPassword: false,
                label: "username".tr,
                hint: "username_hint".tr,
                myIcon: Icon(Icons.person_outline),
                myValidator: (name) => isValidName(name!.trim()),
                keyboardType: TextInputType.name),
          ),
          Container(
            decoration: BoxDecoration(
              color: Get.theme.accentColor,
              borderRadius: BorderRadius.circular(1.5 * heightMultiplier),
            ),
            margin: EdgeInsetsDirectional.only(
                end: 6 * widthMultiplier,
                start: 6 * widthMultiplier,
                top: 1.5 * heightMultiplier),
            child: AuthFormField(
                controller: _passwordController,
                myFocusNode: _passwordNode,
                nextFocusNode: _confirmPasswordNode,
                isPassword: true,
                label: "password".tr,
                hint: "password_hint".tr,
                myIcon: Icon(Icons.lock),
                myValidator: (password) => isValidPassword(password),
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
                top: 1.5 * heightMultiplier,
                bottom: 3 * heightMultiplier),
            child: AuthFormField(
                controller: _confirmPasswordController,
                myFocusNode: _confirmPasswordNode,
                isPassword: true,
                onComplete: () {
                  closeKeyboard(context);
                  if (_firstKey.currentState!.validate()) {
                    controller.updateFirstPageInfo(
                        email: _emailController.text.trim(),
                        name: _nameController.text.trim(),
                        password: _passwordController.text,
                        username: _usernameController.text.trim());
                  }
                },
                label: "confirm_password".tr,
                hint: "confirm_password_hint".tr,
                myIcon: Icon(Icons.password),
                myValidator: (confirm) =>
                    confirmPassword(_passwordController.text, confirm),
                keyboardType: TextInputType.name),
          ),
          Container(
              width: 75 * widthMultiplier,
              height: 8 * heightMultiplier,
              child: ElevatedButton(
                  onPressed: () {
                    closeKeyboard(context);
                    if (_firstKey.currentState!.validate()) {
                      controller.updateFirstPageInfo(
                          email: _emailController.text.trim(),
                          name: _nameController.text.trim(),
                          password: _passwordController.text,
                          username: _usernameController.text.trim());
                    }
                  },
                  child: Text(
                    "continue".tr,
                    style: TextStyle(fontSize: 3.6 * textMultiplier),
                  ))),
          Align(
            child: TextButton(
                onPressed: () {
                  Get.toNamed(AppRoutesNames.loginScreen);
                },
                child: Text("have_account".tr)),
            alignment: AlignmentDirectional.centerStart,
          ),
          Align(
            alignment: AlignmentDirectional.bottomEnd,
            child: Padding(
              padding: EdgeInsetsDirectional.only(
                  end: 2 * widthMultiplier, top: 3 * heightMultiplier),
              child: TextButton(
                onPressed: () {
                  SessionManagement.createGuestSession();
                  Get.offAllNamed(AppRoutesNames.bottomBarScreen);
                },
                child: Text("continue_guest".tr),
              ),
            ),
          )
        ],
      ),
    );
  }

  Form _buildSecondForm(BuildContext context, RegisterController controller) {
    return Form(
      key: _secondKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Get.theme.accentColor,
              borderRadius: BorderRadius.circular(1.5 * heightMultiplier),
            ),
            margin: EdgeInsets.symmetric(horizontal: 6 * widthMultiplier),
            child: AuthFormField(
                controller: _phoneController,
                myFocusNode: _phoneNode,
                nextFocusNode: _addressNode,
                maximum: 11,
                isPassword: false,
                label: "phone".tr,
                hint: "phone_hint".tr,
                myIcon: Icon(Icons.phone_android),
                myValidator: (phone) => isValidPhone(phone),
                keyboardType: TextInputType.phone),
          ),
          Container(
            decoration: BoxDecoration(
              color: Get.theme.accentColor,
              borderRadius: BorderRadius.circular(1.5 * heightMultiplier),
            ),
            margin: EdgeInsetsDirectional.only(
                end: 6 * widthMultiplier,
                start: 6 * widthMultiplier,
                top: 1.5 * heightMultiplier,
                bottom: 3 * heightMultiplier),
            child: AuthFormField(
                controller: _addressController,
                myFocusNode: _addressNode,
                isPassword: false,
                label: "address".tr,
                hint: "address_hint".tr,
                myIcon: Icon(Icons.home),
                onComplete: () {
                  closeKeyboard(context);
                  controller.updateSecondPageInfo(_phoneController.text.trim(),
                      _addressController.text.trim());
                },
                myValidator: (address) {
                  return address!.isNotEmpty ? null : "address_hint".tr;
                },
                keyboardType: TextInputType.streetAddress),
          ),
          Container(
              width: 75 * widthMultiplier,
              height: 8 * heightMultiplier,
              child: ElevatedButton(
                  onPressed: () {
                    closeKeyboard(context);
                    controller.updateSecondPageInfo(
                        _phoneController.text.trim(),
                        _addressController.text.trim());
                  },
                  child: Text(
                    _phoneController.text.trim().isEmpty &&
                            _addressController.text.trim().isEmpty
                        ? "skip".tr
                        : "continue".tr,
                    style: TextStyle(fontSize: 3.6 * textMultiplier),
                  ))),
        ],
      ),
    );
  }

  Widget _buildThirdPage(RegisterController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            Get.dialog(AlertDialog(
              title: Text("choose_image".tr),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                      controller.pickImage(ImageSource.camera);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.camera_alt,
                          color: mainColor,
                        ),
                        Text(
                          "camera".tr,
                          style: TextStyle(color: mainColor),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                      controller.pickImage(ImageSource.gallery);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.image,
                          color: mainColor,
                        ),
                        Text(
                          "gallery".tr,
                          style: TextStyle(color: mainColor),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text("cancel".tr))
              ],
            ));
          },
          child: CircleAvatar(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.black45),
                ),
                Icon(
                  Icons.add_a_photo,
                  color: Colors.white,
                )
              ],
            ),
            backgroundImage: _imageProvider(controller),
            radius: 15 * imageSizeMultiplier,
          ),
        ),
        Container(
            width: 75 * widthMultiplier,
            height: 8 * heightMultiplier,
            margin: EdgeInsets.only(top: 3 * heightMultiplier),
            child: ElevatedButton(
                onPressed: () {
                  if (controller.image == null) {
                    showErrorDialog("no_selected_image".tr);
                  } else {
                    controller.register();
                  }
                },
                child: Text(
                  "sign_up".tr,
                  style: TextStyle(fontSize: 3.6 * textMultiplier),
                ))),
      ],
    );
  }

  ImageProvider _imageProvider(RegisterController controller) {
    if (controller.image != null) {
      return FileImage(controller.image!);
    } else {
      return AssetImage('assets/images/default_profile_pic.jpg');
    }
  }
}
