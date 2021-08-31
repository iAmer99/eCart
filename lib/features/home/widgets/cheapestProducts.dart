import 'package:ecart/features/home/controller/home_controller.dart';
import 'package:ecart/features/home/widgets/homeProduct.dart';
import 'package:ecart/features/home/widgets/loadingProduct.dart';
import 'package:ecart/features/shared/models/product.dart';
import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheapestProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Cheapest Products",
                style: TextStyle(
                    color: Get.theme.primaryColorDark.withOpacity(0.7),
                    fontSize: 2.2 * textMultiplier),
              ),
              TextButton(onPressed: () {},
                child: Text(""),
                style: ButtonStyle(overlayColor: MaterialStateProperty.all(
                    Colors.transparent)),),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: _items(controller),
          )
        ],
      );
    });
  }

  Row _buildLoading() {
    return Row(
      children: [
        for (var i = 0; i < 5; i++) LoadingProduct(),
      ],
    );
  }

  Widget _items(HomeController controller) {
    if (controller.cheapProductStatus.isLoading) {
      return _buildLoading();
    } else if (controller.cheapProductStatus.isEmpty) {
      return Center(child: Text("No Products Found",
        style: TextStyle(color: Get.theme.primaryColorDark),),);
    } else if (controller.cheapProductStatus.isSuccess) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: _buildProducts(controller.cheapProducts!),
      );
    } else {
      return Center(child: Text(controller.cheapProductStatus.errorMessage!,
        style: TextStyle(color: Get.theme.primaryColorDark),),);
    }
  }

  List<Widget> _buildProducts(List<Product> products) {
    return products.map((product) {
      return HomeProduct(product: product);
    }).toList();
  }

  
}
