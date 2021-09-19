import 'package:ecart/core/session_management.dart';
import 'package:ecart/features/more/controller/more_controller.dart';
import 'package:ecart/features/shared/widgets/appBar.dart';
import 'package:ecart/features/shared/widgets/mustLogin.dart';
import 'package:ecart/routes/routes_names.dart';
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
            ? MustLogin(
          hideCart: true,
          showSettings : true,
        )
            : SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4 * widthMultiplier),
                  child: Column(
                    children: [
                      SizedBox(
                        height: Get.statusBarHeight * 0.4,
                      ),
                      MyAppBar(
                        hideBack: true,
                      ),
                      SizedBox(
                        height: 3 * heightMultiplier,
                      ),
                      CircleAvatar(
                        backgroundImage:
                            _imageProvider(SessionManagement.imageUrl),
                        radius: 15 * imageSizeMultiplier,
                      ),
                      SizedBox(
                        height: 1.5 * heightMultiplier,
                      ),
                      Text(
                        "Welcome " + "${SessionManagement.name}",
                        style: TextStyle(
                          color: Get.theme.primaryColorDark.withOpacity(0.7),
                          fontSize: 2.5 * textMultiplier,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 3 * heightMultiplier,
                      ),
                      _buildButton(
                        onTap: () {
                          Get.toNamed(AppRoutesNames.accountScreen);
                        },
                        icon: Icons.account_circle,
                        title: "My Account",
                      ),
                      _buildButton(
                        onTap: () {
                          Get.toNamed(AppRoutesNames.ordersScreen);
                        },
                        icon: Icons.inventory_2,
                        title: "My Orders",
                      ),
                      _buildButton(
                        onTap: () {
                          Get.toNamed(AppRoutesNames.settingsScreen);
                        },
                        icon: Icons.settings,
                        title: "Settings",
                      ),
                      _buildButton(
                        onTap: () {
                          controller.logout();
                        },
                        icon: Icons.logout,
                        title: "Logout",
                      ),
                    ],
                  ),
                ),
            ),
      ),
    );
  }

  GestureDetector _buildButton(
      {required Function onTap,
      required IconData icon,
      required String title}) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 8 * heightMultiplier,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Get.theme.accentColor,
          borderRadius: BorderRadius.circular(1.5 * heightMultiplier),
        ),
        padding: EdgeInsetsDirectional.only(start: 4 * widthMultiplier),
        margin: EdgeInsetsDirectional.only(top: 1.5 * heightMultiplier),
        child: Row(
          children: [
            Icon(
              icon,
              color: Get.theme.primaryColor,
              size: 9 * imageSizeMultiplier,
            ),
            SizedBox(
              width: 2.5 * widthMultiplier,
            ),
            Text(
              title,
              style: TextStyle(
                  color: Get.theme.primaryColorDark.withOpacity(0.7),
                  fontSize: 3 * textMultiplier),
            ),
          ],
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
