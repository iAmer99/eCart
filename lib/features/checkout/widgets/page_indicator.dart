import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageIndicator extends StatelessWidget {
   PageIndicator({Key? key, required this.index}) : super(key: key);
   final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
       index == 0 ? _buildCurrentCircle() : _buildFullCircle(),
        _buildLine(),
        index == 1 ? _buildCurrentCircle() : _buildEmptyCircle(),
      ],
    );
  }

  Container _buildLine() {
    return Container(
        color: Get.theme.primaryColorDark,
        height: 0.5 * heightMultiplier,
        width: 8 * widthMultiplier,
      );
  }

  Container _buildEmptyCircle() {
    return Container(
        height: 5 * imageSizeMultiplier,
        width: 5 * imageSizeMultiplier,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Get.theme.primaryColorDark, width: 3 ),
        ),
      );
  }
   Container _buildFullCircle() {
     return Container(
       height: 5 * imageSizeMultiplier,
       width: 5 * imageSizeMultiplier,
       decoration: BoxDecoration(
         shape: BoxShape.circle,
         border: Border.all(color: Get.theme.primaryColorDark, width: 3 ),
         color: Get.theme.primaryColor,
       ),
     );
   }
   Container _buildCurrentCircle() {
     return Container(
       height: 5 * imageSizeMultiplier,
       width: 5 * imageSizeMultiplier,
       padding: EdgeInsets.all(0.5 * imageSizeMultiplier),
       child: Container(
         height: 3.8 * imageSizeMultiplier,
         width: 3.8 * imageSizeMultiplier,
         decoration: BoxDecoration(
           shape: BoxShape.circle,
           color: Get.theme.primaryColor
         ),
       ),
       decoration: BoxDecoration(
         shape: BoxShape.circle,
         border: Border.all(color: Get.theme.primaryColorDark, width: 0.7 * imageSizeMultiplier ),
       ),
     );
   }
}
