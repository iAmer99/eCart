import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class LoadingProduct extends StatelessWidget {
  const LoadingProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Colors.grey.shade300,
      child: Container(
        margin: EdgeInsetsDirectional.only(
            top: .6 * heightMultiplier,
            bottom: .6 * heightMultiplier,
            end: 2.5 * widthMultiplier),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(1.5 * heightMultiplier),
              child: Container(
                width: 31 * imageSizeMultiplier,
                height: 31 * imageSizeMultiplier,
                color: Colors.white,
              ),
            ),
            SizedBox(height: heightMultiplier),
            Container(
              height: 6 * heightMultiplier,
              color: Get.theme.canvasColor,
            ),
            SizedBox(height: heightMultiplier),
            Container(
              height: 5 * heightMultiplier,
              color: Get.theme.canvasColor,
            ),
          ],
        ),
      ),
    );
  }
}
