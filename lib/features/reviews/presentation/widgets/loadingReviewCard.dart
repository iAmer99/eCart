import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingReviewCard extends StatelessWidget {
  const LoadingReviewCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Colors.grey.shade300,
      child: Container(
        margin: EdgeInsetsDirectional.only(bottom: heightMultiplier),
        height: 25 * heightMultiplier,
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 9 * imageSizeMultiplier,
                ),
                SizedBox(
                  width: 2 * widthMultiplier,
                ),
                Expanded(
                  child: Container(
                    height: 9 * imageSizeMultiplier,
                    width: double.infinity,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            SizedBox(height: heightMultiplier,),
            Container(
              height: 10 * heightMultiplier,
              width: double.infinity,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
