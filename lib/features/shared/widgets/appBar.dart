import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if(Navigator.canPop(context)) Expanded(child: BackButton(color: Get.theme.primaryColorDark,), flex: 1,),
        Expanded(
          flex: 6,
          child: Container(
            width: double.infinity,
            decoration:BoxDecoration(
                borderRadius:
                BorderRadius.circular(heightMultiplier),
                border: Border.all(
                    color: Get.theme.primaryColorDark.withOpacity(0.1)
                )
            ),
            alignment: AlignmentDirectional.centerStart,
            child: IgnorePointer(
              child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "What are you looking for?",
                  hintStyle: TextStyle(
                    color: Get.theme.primaryColorDark.withOpacity(0.7),
                  ),
                  prefixIcon: Icon(Icons.search, color: Get.theme.primaryColorDark.withOpacity(0.7),)
                ),
              ),
            ),
          ),
        ),
        Expanded(flex: 1 , child: SvgPicture.asset("assets/svg/cart.svg", color: Get.theme.primaryColor, height: 8 * imageSizeMultiplier,))
      ],
    );
  }
}
