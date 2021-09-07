import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageIndicator extends StatelessWidget {
  const ImageIndicator({Key? key, required this.length, required this.current}) : super(key: key);
  final int length;
  final int current;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(bottom: heightMultiplier),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for(var i = 0; i < length; i++)
            i == current ? _buildFullCircle() : _buildEmptyCircle()
        ],
      ),
    );
  }

  Widget _buildEmptyCircle() {
    return Padding(
      padding: EdgeInsetsDirectional.only(end: 1 * widthMultiplier),
      child: Container(
        height: 4 * imageSizeMultiplier,
        width: 4 * imageSizeMultiplier,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Get.theme.primaryColorDark.withOpacity(0.7), width: 1.5 ),
          color: Get.theme.primaryColorDark.withOpacity(0.7)
        ),
      ),
    );
  }
  Widget _buildFullCircle() {
    return Padding(
      padding: EdgeInsetsDirectional.only(end: 1 * widthMultiplier),
      child: Container(
        height: 4 * imageSizeMultiplier,
        width: 4 * imageSizeMultiplier,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Get.theme.primaryColorDark.withOpacity(0.7), width: 1.5 ),
          color: Get.theme.primaryColor,
        ),
      ),
    );
  }
}
