import 'package:ecart/core/session_management.dart';
import 'package:ecart/features/home/controller/home_controller.dart';
import 'package:ecart/features/home/widgets/categoriesSlider.dart';
import 'package:ecart/features/home/widgets/cheapestProducts.dart';
import 'package:ecart/features/home/widgets/popularProducts.dart';
import 'package:ecart/features/home/widgets/saleBanner.dart';
import 'package:ecart/features/shared/widgets/appBar.dart';
import 'package:ecart/routes/routes_names.dart';
import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async{
             controller.getCategories();
             controller.getCheapProducts();
             controller.getPopularProducts();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4 * widthMultiplier),
              child: Column(
                children: [
                  SizedBox(
                    height: Get.statusBarHeight * 0.4,
                  ),
                  MyAppBar(),
                  CategoriesSlider(),
                  SizedBox(
                    height: heightMultiplier,
                  ),
                  SaleBanner(),
                  SizedBox(
                    height: heightMultiplier,
                  ),
                  CheapestProducts(),
                  SizedBox(
                    height: heightMultiplier,
                  ),
                  PopularProducts(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
