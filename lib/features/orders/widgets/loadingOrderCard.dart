import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingOrderCard extends StatelessWidget {
  LoadingOrderCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Colors.grey.shade300,
      child: Container(
        height: 30 * imageSizeMultiplier,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(1.5 * heightMultiplier),
        ),
        margin: EdgeInsetsDirectional.only(bottom: 2 * heightMultiplier),
      ),
    );
  }
}
