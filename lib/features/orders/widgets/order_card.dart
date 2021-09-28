import 'package:ecart/features/orders/repository/models/order.dart';
import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class OrderCard extends StatelessWidget {
  OrderCard({Key? key, required this.order, required this.index})
      : super(key: key);
  final Order order;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30 * imageSizeMultiplier,
      width: double.infinity,
      color: Colors.transparent,
      margin: EdgeInsetsDirectional.only(
        bottom: 1 * heightMultiplier,
      ),
      padding: EdgeInsetsDirectional.only(
        end: widthMultiplier,
      ),
      child: Card(
        color: Get.theme.canvasColor,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(1.5 * heightMultiplier),
        ),
        child: Row(
          children: [
            Container(
              height: 30 * imageSizeMultiplier,
              width: 30 * imageSizeMultiplier,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.horizontal(
                  start: Radius.circular(1.5 * heightMultiplier),
                ),
              ),
              child: SvgPicture.asset(
                'assets/svg/order.svg',
                height: 20 * imageSizeMultiplier,
              ),
            ),
            SizedBox(
              width: 3 * widthMultiplier,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.only(top: heightMultiplier),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "order_number".trParams({
                        "number" : (index + 1).toString()
                      }),
                      style: TextStyle(
                        color: Get.theme.primaryColorDark,
                        fontSize: 2 * textMultiplier,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    SizedBox(
                      height: heightMultiplier,
                    ),
                    Text(
                      "price".trParams({
                        "price" : order.totalPrice.toString()
                      }),
                      style: TextStyle(
                        color: Get.theme.primaryColorDark.withOpacity(0.8),
                        fontSize: 2 * textMultiplier,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Text(
                  order.status!,
                  style: TextStyle(
                    color: Get.theme.primaryColor.withOpacity(0.8),
                    fontSize: 2 * textMultiplier,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 4 * widthMultiplier,
            ),
          ],
        ),
      ),
    );
  }
}
