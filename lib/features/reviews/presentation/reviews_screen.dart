import 'package:ecart/core/session_management.dart';
import 'package:ecart/features/reviews/controller/reviews_controller.dart';
import 'package:ecart/features/reviews/modes.dart';
import 'package:ecart/features/reviews/presentation/editor_screen.dart';
import 'package:ecart/features/reviews/repository/models/reviews_response.dart';
import 'package:ecart/features/shared/models/user_response.dart';
import 'package:ecart/features/shared/models/product.dart';
import 'package:ecart/features/shared/widgets/appBar.dart';
import 'package:ecart/routes/routes_names.dart';
import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:shimmer/shimmer.dart';

import 'widgets/header.dart';
import 'widgets/loadingReviewCard.dart';
import 'widgets/review_card.dart';

class ReviewsScreen extends GetView<ReviewsController> {
  ReviewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        Center(
          child: TextButton(
              onPressed: () {
                if (SessionManagement.isGuest) {
                  Get.toNamed(AppRoutesNames.loginScreen);
                } else {
                  Get.to(() => EditorReview(),
                      transition: Transition.downToUp, arguments: Mode.Write);
                }
              },
              child: Text(
                "write_a_review".tr,
                style: TextStyle(fontSize: 3 * textMultiplier),
              )),
        ),
      ],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4 * widthMultiplier),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: Get.statusBarHeight * 0.4,
              ),
              MyAppBar(
                title: Text(
                  "reviews".tr,
                  style: TextStyle(
                    color: Get.theme.primaryColorDark,
                    fontSize: 2.2 * textMultiplier,
                  ),
                ),
                hideCart: true,
              ),
              SizedBox(
                height: 2 * heightMultiplier,
              ),
              GetBuilder<ReviewsController>(
                builder: (controller) {
                  return Expanded(
                    child: LazyLoadScrollView(
                      onEndOfPage: () {
                        controller.loadNextPage();
                        controller.getReviews();
                      },
                      isLoading: controller.lastPage,
                      child: Column(
                        children: [
                          if (controller.status.isEmpty)
                            Expanded(
                              child: Center(
                                child: Text(
                                  "no_reviews".tr,
                                  style: TextStyle(
                                      color: Get.theme.primaryColorDark,
                                      fontSize: 2.2 * textMultiplier),
                                ),
                              ),
                            ),
                          if (controller.status.isLoading)
                            Expanded(
                              child: ListView(
                                children: [
                                  SizedBox(
                                    height: heightMultiplier,
                                  ),
                                  _loadingHeader(),
                                  SizedBox(
                                    height: heightMultiplier,
                                  ),
                                  for (var i = 0; i < 10; i++)
                                    LoadingReviewCard(),
                                ],
                              ),
                            ),
                          if (controller.status.isSuccess)
                            Expanded(
                              child: ListView(
                                children: [
                                  ReviewsHeader(),
                                  SizedBox(
                                    height: heightMultiplier,
                                  ),
                                  ...(controller.reviewsData.map((map) {
                                    User user = map["user"] as User;
                                    Review review = map["review"] as Review;
                                    return ReviewCard(
                                      user: user,
                                      review: review,
                                    );
                                  })),
                                  if (controller.status.isLoadingMore)
                                    LoadingReviewCard(),
                                ],
                              ),
                            ),
                          if (controller.status.isError)
                            Expanded(
                              child: Center(
                                child: Text(
                                  controller.status.errorMessage!,
                                  style: TextStyle(
                                      color: Get.theme.primaryColorDark,
                                      fontSize: 2.2 * textMultiplier),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _loadingHeader() {
    return Shimmer.fromColors(
      child: Container(
        height: 25 * heightMultiplier,
        width: double.infinity,
        color: Colors.white,
      ),
      baseColor: Colors.white,
      highlightColor: Colors.grey.shade300,
    );
  }
}
