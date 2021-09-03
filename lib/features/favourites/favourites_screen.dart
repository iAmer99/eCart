import 'package:ecart/core/session_management.dart';
import 'package:ecart/features/favourites/controller/favourite_controller.dart';
import 'package:ecart/features/shared/widgets/appBar.dart';
import 'package:ecart/features/shared/widgets/loadingProductCard.dart';
import 'package:ecart/features/shared/widgets/product_card.dart';
import 'package:ecart/routes/routes_names.dart';
import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavouritesController>(
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: SessionManagement.isUser ? _buildUserFavourites(controller) : _buildGuest(),
          ),
        );
      },
    );
  }

  RefreshIndicator _buildUserFavourites(FavouritesController controller) {
    return RefreshIndicator(
            onRefresh: () async {
              controller.getFavourites();
            },
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 4 * widthMultiplier),
              child: Column(
                children: [
                  SizedBox(
                    height: Get.statusBarHeight * 0.4,
                  ),
                  MyAppBar(),
                  SizedBox(
                    height: 3 * heightMultiplier,
                  ),
                  if (controller.status.isEmpty)
                    Expanded(
                      child: Center(
                        child: Text(
                          "No Favourites Found",
                          style: TextStyle(
                              color: Get.theme.primaryColorDark,
                              fontSize: 2.2 * textMultiplier),
                        ),
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
                  if (controller.status.isSuccess)
                    Expanded(
                      child: ListView(
                        children: [
                          ...(controller.favourites.map((product) {
                            return ProductCard(
                              product: product,
                              remove: (String id) =>
                                  controller.removeFromFavourites(id),
                            );
                          })),
                        ],
                      ),
                    ),
                  if (controller.status.isLoading)
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            for (var i = 0; i < 7; i++) LoadingProductCard()
                          ],
                        ),
                      ),
                    )
                ],
              ),
            ),
          );
  }

  Padding _buildGuest() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4 * widthMultiplier),
      child: Column(
        children: [
          SizedBox(
            height: Get.statusBarHeight * 0.4,
          ),
          MyAppBar(),
          SizedBox(
            height: 2 * heightMultiplier,
          ),
          Expanded(
              child: Center(
                  child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 40 * widthMultiplier,
                  height: 8 * heightMultiplier,
                  margin:
                      EdgeInsetsDirectional.only(bottom: 1 * heightMultiplier),
                  child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed(AppRoutesNames.registerScreen);
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(fontSize: 3.6 * textMultiplier),
                      ))),
              TextButton(
                onPressed: () {
                  Get.toNamed(AppRoutesNames.loginScreen);
                },
                child: Text(
                  "Already have an account? Login",
                  style: TextStyle(fontSize: 2 * textMultiplier),
                ),
              ),
            ],
          ))),
        ],
      ),
    );
  }
}
