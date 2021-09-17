import 'dart:io';

import 'package:ecart/core/session_management.dart';
import 'package:ecart/features/shared/widgets/appBar.dart';
import 'package:ecart/features/shared/widgets/myTextFormField.dart';
import 'package:ecart/features/update_account/controller/account_controller.dart';
import 'package:ecart/utils/colors.dart';
import 'package:ecart/utils/helper_functions.dart';
import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController =
      TextEditingController(text: SessionManagement.email);
  final FocusNode _emailNode = FocusNode();
  final TextEditingController _nameController =
      TextEditingController(text: SessionManagement.name);
  final FocusNode _nameNode = FocusNode();
  final TextEditingController _phoneController =
      TextEditingController(text: SessionManagement.phone);
  final FocusNode _phoneNode = FocusNode();
  final TextEditingController _addressController =
      TextEditingController(text: SessionManagement.address);
  final FocusNode _addressNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(
      builder: (_controller){
        return ModalProgressHUD(
          inAsyncCall: _controller.status.isLoading,
          child: GestureDetector(
            onTap: () {
              closeKeyboard(context);
            },
            child: Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4 * widthMultiplier),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: Get.statusBarHeight * 0.4,
                          ),
                          MyAppBar(
                            hideCart: true,
                            title: Text(
                              "Update Profile",
                              style: TextStyle(
                                color: Get.theme.primaryColorDark,
                                fontSize: 2.5 * textMultiplier,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 3 * heightMultiplier,
                          ),
                          ObxValue(
                                (Rx<File> image) => GestureDetector(
                              onTap: () {
                                Get.dialog(AlertDialog(
                                  title: Text("Choose Image Source"),
                                  content: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Get.back();
                                          _controller.pickImage(ImageSource.camera);
                                        },
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.camera_alt,
                                              color: mainColor,
                                            ),
                                            Text(
                                              "Camera",
                                              style: TextStyle(color: mainColor),
                                            )
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Get.back();
                                          _controller.pickImage(ImageSource.gallery);
                                        },
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.image,
                                              color: mainColor,
                                            ),
                                            Text(
                                              "Gallery",
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
                                        child: Text("Cancel"))
                                  ],
                                ));
                              },
                              child: CircleAvatar(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.black45),
                                    ),
                                    Icon(
                                      Icons.add_a_photo,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                                backgroundImage: _imageProvider(image.value),
                                radius: 15 * imageSizeMultiplier,
                              ),
                            ),
                            _controller.image,
                          ),
                          SizedBox(
                            height: 1.5 * heightMultiplier,
                          ),
                          MyTextFormField(
                            controller: _nameController,
                            node: _nameNode,
                            nextNode: _emailNode,
                            keyboardType: TextInputType.name,
                            label: "Name",
                            icon: Icon(Icons.person),
                          ),
                          MyTextFormField(
                            controller: _emailController,
                            node: _emailNode,
                            nextNode: _phoneNode,
                            keyboardType: TextInputType.emailAddress,
                            label: "Email",
                            icon: Icon(Icons.email),
                          ),
                          MyTextFormField(
                            controller: _phoneController,
                            node: _phoneNode,
                            nextNode: _addressNode,
                            keyboardType: TextInputType.phone,
                            label: "Phone",
                            icon: Icon(Icons.phone_android),
                          ),
                          MyTextFormField(
                            controller: _addressController,
                            node: _addressNode,
                            onComplete: () {
                              closeKeyboard(context);
                              _controller.updateData(
                                name: _nameController.text,
                                email: _emailController.text,
                                address: _addressController.text,
                                phone: _phoneController.text,
                              );
                            },
                            label: "Address",
                            icon: Icon(Icons.map),
                            keyboardType: TextInputType.streetAddress,
                          ),
                          Container(
                            width: 75 * widthMultiplier,
                            height: 8 * heightMultiplier,
                            margin: EdgeInsets.only(bottom: 2 * heightMultiplier),
                            child: ElevatedButton(
                              onPressed: () {
                                closeKeyboard(context);
                                _controller.updateData(
                                  name: _nameController.text,
                                  email: _emailController.text,
                                  address: _addressController.text,
                                  phone: _phoneController.text,
                                );
                              },
                              child: Text(
                                "Save",
                                style: TextStyle(fontSize: 3.6 * textMultiplier),
                              ),
                            ),
                          ),
                        ],
                      ),
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

  ImageProvider _imageProvider(File image) {
    if (image.path.isNotEmpty) {
      return FileImage(image);
    } else if (SessionManagement.imageUrl != null) {
      return NetworkImage(SessionManagement.imageUrl!);
    } else {
      return AssetImage('assets/images/default_profile_pic.jpg');
    }
  }
}
