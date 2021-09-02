import 'package:chips_choice/chips_choice.dart';
import 'package:ecart/features/products/controller/products_controller.dart';
import 'package:ecart/features/shared/models/category.dart';
import 'package:ecart/features/shared/widgets/appBar.dart';
import 'package:ecart/features/shared/widgets/loadingProductCard.dart';
import 'package:ecart/features/shared/widgets/product_card.dart';
import 'package:ecart/features/shared/widgets/sort_selection.dart';
import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsScreen extends StatelessWidget {
  ProductsScreen({Key? key}) : super(key: key);
  final Category category = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductsController>(
      builder: (controller){
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4 * widthMultiplier),
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.statusBarHeight * 0.4,
                    ),
                    MyAppBar(title: Center(
                      child: Text(
                        category.name!,
                        style: TextStyle(
                          color: Get.theme.primaryColorDark,
                          fontSize: 3.6 * textMultiplier,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),),
                    SizedBox(
                      height: 2 * heightMultiplier,
                    ),
                    SortSelection(onSelection: (index){
                      controller.getSorting(index);
                      controller.getProducts();
                    },),
                    if (controller.status.isEmpty)
                      Center(
                        child: Text(
                          "No Products Found",
                          style: TextStyle(
                              color: Get.theme.primaryColorDark,
                              fontSize: 2.2 * textMultiplier),
                        ),
                      ),
                    if (controller.status.isError)
                      Center(
                        child: Text(
                          controller.status.errorMessage!,
                          style: TextStyle(
                              color: Get.theme.primaryColorDark,
                              fontSize: 2.2 * textMultiplier),
                        ),
                      ),
                    if (controller.status.isSuccess)
                      ...(controller.products.map((product) {
                        return ProductCard(
                          product: product,
                        );
                      })),
                    if (controller.status.isLoading)
                      for (var i = 0; i < 7; i++) LoadingProductCard()
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