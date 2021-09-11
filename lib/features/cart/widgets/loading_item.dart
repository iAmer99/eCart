import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingCartItem extends StatelessWidget {
  const LoadingCartItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildItem(),
        Divider(),
        _buildItem()
      ],
    );
  }

  Shimmer _buildItem() {
    return Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: Colors.grey.shade300,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(1.5 * heightMultiplier),
              child: Container(
                height: 23 * imageSizeMultiplier,
                width: 23 * imageSizeMultiplier,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 2 * widthMultiplier,
            ),
            Expanded(
              child: Container(
                height: 23 * imageSizeMultiplier,
                width: double.infinity,
                color: Colors.white,
              ),
            ),
          ],
        ),
      );
  }
}
