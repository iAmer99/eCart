import 'package:ecart/features/reviews/controller/reviews_controller.dart';
import 'package:ecart/features/shared/models/product.dart';
import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class ReviewsHeader extends StatelessWidget {
  ReviewsHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReviewsController>(
      builder: (controller){
        Product product = controller.product;
        return Container(
          height: 25 * heightMultiplier,
          width: double.infinity,
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(
                height: heightMultiplier,
              ),
              Text(
                "${product.ratingsAverage}",
                style: TextStyle(
                  color: Get.theme.primaryColorDark,
                  fontSize: 3.6 * textMultiplier,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: heightMultiplier,
              ),
              RatingBar.builder(
                initialRating: product.ratingsAverage!.toDouble(),
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                ignoreGestures: true,
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Get.theme.primaryColor,
                ),
                onRatingUpdate: (rating) {},
              ),
              SizedBox(height: heightMultiplier,),
              Text(
                "rating_based_on".trParams({
                  "number": product.ratingsQuantity.toString()
                }),
                style: TextStyle(
                  color: Get.theme.primaryColorDark.withOpacity(0.5),
                  fontSize: 2.2 * textMultiplier,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
