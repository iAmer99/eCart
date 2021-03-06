import 'package:ecart/core/session_management.dart';
import 'package:ecart/features/products/controller/products_controller.dart';
import 'package:ecart/features/shared/models/category.dart';
import 'package:ecart/features/shared/widgets/appBar.dart';
import 'package:ecart/features/shared/widgets/loadingProductCard.dart';
import 'package:ecart/features/shared/widgets/product_card.dart';
import 'package:ecart/features/shared/widgets/sort_selection.dart';
import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class ProductsScreen extends StatelessWidget {
  ProductsScreen({Key? key}) : super(key: key);
  final Category category = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductsController>(
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4 * widthMultiplier),
              child: LazyLoadScrollView(
                onEndOfPage: (){
                  controller.loadNextPage();
                  controller.getProducts();
                },
                isLoading: controller.lastPage,
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.statusBarHeight * 0.4,
                    ),
                    MyAppBar(),
                    SizedBox(
                      height: 2 * heightMultiplier,
                    ),
                    Align(
                      alignment: AlignmentDirectional.center,
                      child: Text(
                        category.name!,
                        style: TextStyle(
                          color: Get.theme.primaryColorDark.withOpacity(0.7),
                          fontSize: 2.5 * textMultiplier,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    SortSelection(
                      onSelection: (index) {
                        controller.getSorting(index);
                        controller.getProducts();
                      },
                    ),
                    if (controller.status.isEmpty)
                      Expanded(
                        child: Center(
                          child: Text(
                            "no_products".tr,
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
                            ...(controller.products.map((product){
                              return ProductCard(product: product,);
                            })),
                            if(controller.status.isLoadingMore)
                              LoadingProductCard(),
                          ],
                           ),
                      ),
                    if (controller.status.isLoading)
                      Expanded(child: ListView(
                        children: [
                          for (var i = 0; i < 7; i++) LoadingProductCard()
                        ],
                      ))
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
