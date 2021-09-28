import 'package:ecart/routes/routes_names.dart';
import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'appBar.dart';

class MustLogin extends StatelessWidget {
  MustLogin({Key? key, this.hideCart, this.showSettings = false, this.title}) : super(key: key);
  final bool? hideCart;
  final bool showSettings;
  final Widget? title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4 * widthMultiplier),
      child: Column(
        children: [
          SizedBox(
            height: Get.statusBarHeight * 0.4,
          ),
          MyAppBar(
            hideCart: hideCart,
            showSettings: showSettings,
            title: title,
          ),
          SizedBox(
            height: 2 * heightMultiplier,
          ),
          Expanded(
              child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 40 * widthMultiplier,
                          height: 8 * heightMultiplier,
                          margin:
                          EdgeInsetsDirectional.only(bottom: 1 * heightMultiplier),
                          child: ElevatedButton(
                              onPressed: () {
                                Get.toNamed(AppRoutesNames.registerScreen);
                              },
                              child: Text(
                                "sign_up".tr,
                                style: TextStyle(fontSize: 3.6 * textMultiplier),
                              ))),
                      TextButton(
                        onPressed: () {
                          Get.toNamed(AppRoutesNames.loginScreen);
                        },
                        child: Text(
                          "have_account".tr,
                          style: TextStyle(fontSize: 2 * textMultiplier),
                        ),
                      ),
                    ],
                  ))),
        ],
      ),
    );
  }
}
