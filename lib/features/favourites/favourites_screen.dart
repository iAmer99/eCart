import 'package:ecart/core/session_management.dart';
import 'package:ecart/features/favourites/controller/favourite_controller.dart';
import 'package:ecart/features/shared/widgets/appBar.dart';
import 'package:ecart/features/shared/widgets/loadingProductCard.dart';
import 'package:ecart/features/shared/widgets/mustLogin.dart';
import 'package:ecart/features/shared/widgets/product_card.dart';
import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavouritesController>(
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: SessionManagement.isUser ? _buildUserFavourites(controller) : MustLogin(),
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
                  MyAppBar(
                    hideBack: true,
                  ),
                  SizedBox(
                    height: 3 * heightMultiplier,
                  ),
                  if (controller.status.isEmpty)
                    Expanded(
                      child: Center(
                        child: Text(
                          "no_favourites".tr,
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

}
