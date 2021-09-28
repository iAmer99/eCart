import 'package:ecart/core/session_management.dart';
import 'package:ecart/features/reviews/controller/reviews_controller.dart';
import 'package:ecart/features/reviews/modes.dart';
import 'package:ecart/features/reviews/repository/models/reviews_response.dart';
import 'package:ecart/features/shared/localization/texts.dart';
import 'package:ecart/features/shared/models/user_response.dart';
import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../editor_screen.dart';

class ReviewCard extends GetView<ReviewsController> {
  ReviewCard({Key? key, required this.user, required this.review})
      : super(key: key);
  final User user;
  final Review review;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(bottom: heightMultiplier),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: _imageProvider(user.profileImage),
                backgroundColor: Get.theme.primaryColor,
                radius: 9 * imageSizeMultiplier,
              ),
              SizedBox(
                width: 2 * widthMultiplier,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name!,
                    style: TextStyle(
                      color: Get.theme.primaryColorDark,
                      fontSize: 2 * textMultiplier,
                    ),
                  ),
                  RatingBar.builder(
                    initialRating: review.rating!.toDouble(),
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 5 * imageSizeMultiplier,
                    itemPadding: EdgeInsetsDirectional.only(end: 4.0),
                    ignoreGestures: true,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Get.theme.primaryColor,
                    ),
                    onRatingUpdate: (rating) {},
                  ),
                ],
              ),
              if (user.id == SessionManagement.userID)
                Expanded(
                  child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: PopupMenuButton(
                      color: Get.theme.accentColor,
                      icon: Icon(
                        Icons.more_vert,
                        color: Get.theme.primaryColorDark,
                      ),
                      itemBuilder: (BuildContext context) {
                        return [
                          PopupMenuItem(
                            child: Text(
                              "edit".tr,
                              style:
                                  TextStyle(color: Get.theme.primaryColorDark),
                            ),
                            value: Mode.Edit,
                          ),
                          PopupMenuItem(
                            child: Text(
                              "delete".tr,
                              style:
                                  TextStyle(color: Get.theme.primaryColorDark),
                            ),
                            value: Mode.Delete,
                          )
                        ];
                      },
                      onSelected: (mode) {
                        if (mode == Mode.Delete) {
                          showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                    backgroundColor: Get.theme.canvasColor,
                                    title: Text(
                                      "are_you_sure".tr,
                                      style: TextStyle(
                                        color: Get.theme.primaryColorDark,
                                      ),
                                    ),
                                    content: Text(
                                      "are_you_sure_review".tr,
                                      style: TextStyle(
                                        color: Get.theme.primaryColorDark,
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(ctx).pop();
                                          },
                                          child: Text(
                                            "cancel".tr,
                                          )),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(ctx).pop();
                                            controller.deleteReview(review.id!);
                                          },
                                          child: Text(
                                            "delete".tr,
                                            style: TextStyle(color: Colors.red),
                                          )),
                                    ],
                                  ));
                        } else {
                          Get.to(
                              () => EditorReview(
                                    review: review,
                                  ),
                              arguments: Mode.Edit);
                        }
                      },
                    ),
                  ),
                )
            ],
          ),
          SizedBox(
            height: heightMultiplier,
          ),
          Text(
            review.review!,
            style: TextStyle(
                color: Get.theme.primaryColorDark.withOpacity(0.7),
                fontSize: 1.8 * textMultiplier),
          ),
          Divider(),
        ],
      ),
    );
  }

  ImageProvider _imageProvider(String? image) {
    if (image != null) {
      return NetworkImage(image);
    } else {
      return AssetImage("assets/images/default.jpg");
    }
  }
}
