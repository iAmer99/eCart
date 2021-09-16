import 'package:ecart/core/remote/dio_util.dart';
import 'package:ecart/core/session_management.dart';
import 'package:ecart/features/more/controller/more_controller.dart';
import 'package:ecart/features/shared/widgets/appBar.dart';
import 'package:ecart/features/shared/widgets/mustLogin.dart';
import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MoreScreen extends GetView<MoreController> {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SessionManagement.isGuest
            ? MustLogin()
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 4 * widthMultiplier),
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.statusBarHeight * 0.4,
                    ),
                    MyAppBar(),
                    SizedBox(
                      height: 3 * heightMultiplier,
                    ),
                    CircleAvatar(
                      backgroundImage:
                          _imageProvider(SessionManagement.imageUrl),
                      radius: 15 * imageSizeMultiplier,
                    ),
                    SizedBox(
                      height: heightMultiplier,
                    ),
                    Text(
                      "Welcome " + "${SessionManagement.name}",
                      style: TextStyle(
                        color: Get.theme.primaryColorDark.withOpacity(0.8),
                        fontSize: 2.5 * textMultiplier,
                      ),
                    ),
                    SizedBox(
                      height: 4 * heightMultiplier,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 8 * heightMultiplier,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Get.theme.accentColor,
                          borderRadius:
                              BorderRadius.circular(1.5 * heightMultiplier),
                        ),
                        padding: EdgeInsetsDirectional.only(
                            start: 2 * widthMultiplier),
                        margin: EdgeInsetsDirectional.only(
                            top: 1.5 * heightMultiplier),
                        child: Row(
                          children: [
                            Icon(
                              Icons.account_circle,
                              color: Get.theme.primaryColor,
                            ),
                            SizedBox(
                              width: 2 * widthMultiplier,
                            ),
                            Text(
                              "My Account",
                              style: TextStyle(
                                  color: Get.theme.primaryColorDark.withOpacity(0.8),
                                  fontSize: 3 * textMultiplier),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }

  ImageProvider _imageProvider(String? image) {
    if (image != null) {
      return NetworkImage(image);
    } else {
      return AssetImage('assets/images/default_profile_pic.jpg');
    }
  }
}
