import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SaleBanner extends StatelessWidget {
  const SaleBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 25 * heightMultiplier,
      decoration: BoxDecoration(
          borderRadius:
          BorderRadius.circular(1.5 * heightMultiplier),
          color: Get.theme.accentColor),
      child: Row(
        children: [
          SizedBox(width: 3.5 * widthMultiplier,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "sale".tr,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 4 * textMultiplier,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "up_to_40".tr,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 2.2 * textMultiplier,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "shop_now".tr,
                style: TextStyle(
                  color: Get.theme.primaryColor,
                  fontSize: 4 * textMultiplier,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(width: 3.5 * widthMultiplier,),
          Expanded(
            child: Container(
              width: double.infinity,
              height: 25 * heightMultiplier,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.horizontal(end: Radius.circular(1.5 * heightMultiplier)),
                // color: Get.theme.primaryColor.withOpacity(0.8)
              ),
              padding: EdgeInsets.only(top: 1.5 * heightMultiplier),
              child: Image.asset("assets/images/model.png", fit: BoxFit.contain,),
            ),
          ),
        ],
      ),
    );
  }
}
