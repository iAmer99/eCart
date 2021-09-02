import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingProductCard extends StatelessWidget {
  LoadingProductCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Colors.grey.shade300,
      child: Container(
        height: 23 * imageSizeMultiplier,
        width: double.infinity,
        color: Colors.transparent,
        margin: EdgeInsetsDirectional.only(bottom: 2 * heightMultiplier),
        child: Row(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(1.5 * heightMultiplier),
                child: Container(
                  width: 23 * imageSizeMultiplier,
                  height: 23 * imageSizeMultiplier,
                  color: Colors.white,
                )),
            SizedBox(
              width: 3 * widthMultiplier,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                height: 23 * imageSizeMultiplier,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadiusDirectional.horizontal(end: Radius.circular(1.5 * heightMultiplier))
                ),
              ),
              ),
          ],
        ),
      ),
    );
  }
}
