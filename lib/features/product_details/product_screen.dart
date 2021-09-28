import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecart/core/session_management.dart';
import 'package:ecart/features/product_details/controller/product_controller.dart';
import 'package:ecart/features/product_details/widgets/image_indicator.dart';
import 'package:ecart/features/product_details/widgets/sizeSelectionMenu.dart';
import 'package:ecart/features/shared/models/product.dart';
import 'package:ecart/features/shared/widgets/appBar.dart';
import 'package:ecart/routes/routes_names.dart';
import 'package:ecart/utils/helper_functions.dart';
import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import 'widgets/colorSelectionMenu.dart';

class ProductDetailsScreen extends StatefulWidget {
  ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ProductController controller = Get.find<ProductController>();
  Product product = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        GetBuilder<ProductController>(
          builder: (controller) {
            return controller.status.isLoading
                ? _buildLoadingBottomBar()
                : Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4 * widthMultiplier),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.decrease();
                              },
                              child: Container(
                                height: 9 * imageSizeMultiplier,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(heightMultiplier),
                                  border: Border.all(
                                      color: Get.theme.primaryColorDark
                                          .withOpacity(0.2)),
                                  color: Get.theme.canvasColor,
                                ),
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.remove,
                                  size: 7 * imageSizeMultiplier,
                                  color: Get.theme.primaryColorDark,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 2 * widthMultiplier,
                            ),
                            Obx(() {
                              return Text(
                                "${controller.quantity}",
                                style: TextStyle(
                                  color: Get.theme.primaryColorDark
                                      .withOpacity(0.7),
                                  fontSize: 3 * textMultiplier,
                                ),
                              );
                            }),
                            SizedBox(
                              width: 2 * widthMultiplier,
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.increase();
                              },
                              child: Container(
                                height: 9 * imageSizeMultiplier,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(heightMultiplier),
                                  border: Border.all(
                                      color: Get.theme.primaryColorDark
                                          .withOpacity(0.2)),
                                  color: Get.theme.canvasColor,
                                ),
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.add,
                                  size: 7 * imageSizeMultiplier,
                                  color: Get.theme.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        ObxValue((RxBool addedToCart) {
                          return Container(
                              height: 8 * heightMultiplier,
                              margin: EdgeInsetsDirectional.only(
                                  bottom: heightMultiplier,
                                  top: heightMultiplier),
                              child: ElevatedButton(
                                  onPressed: () {
                                    if (SessionManagement.isUser) {
                                      if (product.isOutOfStock == true) {
                                        showSnackBar("product_out_of_stock".tr);
                                      } else if (addedToCart.isFalse) {
                                        controller.addToCart();
                                      } else {
                                        Get.toNamed(AppRoutesNames.cartScreen);
                                      }
                                    } else {
                                      Get.toNamed(
                                          AppRoutesNames.registerScreen);
                                    }
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        addedToCart.value
                                            ? Colors.blueGrey
                                            : Get.theme.primaryColor),
                                  ),
                                  child: Text(
                                    addedToCart.value
                                        ? "checkout".tr
                                        : "add_to_cart".tr,
                                    style: TextStyle(
                                        fontSize: 3.6 * textMultiplier),
                                  )));
                        }, controller.addedToCart),
                      ],
                    ),
                  );
          },
        )
      ],
      body: SafeArea(
        child: Padding(
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
                child: ListView(
                  children: [
                    GetBuilder<ProductController>(
                      builder: (controller) {
                        return controller.status.isLoading
                            ? _buildLoadingImage()
                            : Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        height: 25 * heightMultiplier,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              1.5 * heightMultiplier),
                                          color: Get.theme.accentColor,
                                        ),
                                        child: CarouselSlider(
                                            items: controller.img.map((image) {
                                              return ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        1.5 * heightMultiplier),
                                                child: FadeInImage(
                                                  fit: BoxFit.contain,
                                                  placeholder: AssetImage(
                                                      "assets/images/default.jpg"),
                                                  image: NetworkImage(image),
                                                  height: 25 * heightMultiplier,
                                                  width: double.infinity,
                                                ),
                                              );
                                            }).toList(),
                                            options: CarouselOptions(
                                              onPageChanged: (index, _) {
                                                controller.getIndex(index);
                                              },
                                              viewportFraction: 1,
                                            )),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.only(
                                            top: 2 * heightMultiplier,
                                            start: 2 * widthMultiplier),
                                        child: GestureDetector(
                                          onTap: () {
                                            controller.isFavourite
                                                ? controller
                                                    .removeFromFavourites()
                                                : controller.addToFavourites();
                                          },
                                          child: Icon(
                                            controller.isFavourite
                                                ? Icons.favorite
                                                : Icons.favorite_border_rounded,
                                            color: Get.theme.primaryColor,
                                            size: 8 * imageSizeMultiplier,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  ImageIndicator(
                                      length: controller.img.length,
                                      current: controller.index),
                                ],
                              );
                      },
                    ),
                    SizedBox(
                      height: 2 * heightMultiplier,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 6,
                          child: Text(
                            product.name!,
                            style: TextStyle(
                                color:
                                    Get.theme.primaryColorDark.withOpacity(0.8),
                                fontSize: 2 * textMultiplier),
                          ),
                        ),
                        SizedBox(
                          width: widthMultiplier,
                        ),
                        Flexible(
                          flex: 1,
                          child: Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Get.theme.primaryColor,
                                size: 6 * imageSizeMultiplier,
                              ),
                              Text(
                                product.ratingsAverage.toString(),
                                style: TextStyle(
                                    color: Get.theme.primaryColorDark
                                        .withOpacity(0.7),
                                    fontSize: 2 * textMultiplier),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: heightMultiplier,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "price".trParams({
                            "price" : product.priceAfterDiscount!.toString()
                          }),
                          style: TextStyle(
                            color: product.priceDiscount != null &&
                                    product.priceDiscount != 0
                                ? Get.theme.primaryColor
                                : Get.theme.primaryColorDark.withOpacity(0.7),
                            fontSize: 2 * textMultiplier,
                          ),
                        ),
                        if (product.priceDiscount != null &&
                            product.priceDiscount != 0 &&
                            product.isOutOfStock != true)
                          Text(
                            "price".trParams({
                              "price" : product.priceAfterDiscount!.toString()
                            }),
                            style: TextStyle(
                              color:
                                  Get.theme.primaryColorDark.withOpacity(0.5),
                              decoration: TextDecoration.lineThrough,
                              fontSize: 2 * textMultiplier,
                            ),
                          ),
                        if (product.isOutOfStock != null &&
                            product.isOutOfStock == true)
                          Text(
                            "out_of_stock".tr,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 2 * textMultiplier,
                            ),
                          ),
                      ],
                    ),
                    SizedBox(
                      height: 2 * heightMultiplier,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.all(heightMultiplier),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(1 * heightMultiplier),
                              border: Border.all(
                                  color: Get.theme.primaryColorDark
                                      .withOpacity(0.2)),
                              color: Get.theme.canvasColor),
                          child: Text(
                            "product".tr,
                            style: TextStyle(
                                color: Get.theme.primaryColor,
                                fontSize: 2.2 * textMultiplier),
                          ),
                        ),
                        SizedBox(
                          width: 2 * widthMultiplier,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRoutesNames.reviewsScreen,
                                arguments: product);
                          },
                          child: Container(
                            padding: EdgeInsets.all(heightMultiplier),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(1 * heightMultiplier),
                                border: Border.all(
                                    color: Get.theme.primaryColorDark
                                        .withOpacity(0.2)),
                                color: Get.theme.canvasColor),
                            child: Text(
                              "reviews".tr,
                              style: TextStyle(
                                  color: Get.theme.primaryColorDark
                                      .withOpacity(0.8),
                                  fontSize: 2.2 * textMultiplier),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (product.sizes != null)
                      SizedBox(
                        height: 2 * heightMultiplier,
                      ),
                    if (product.sizes != null)
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              "sizes".tr,
                              style: TextStyle(
                                color:
                                    Get.theme.primaryColorDark.withOpacity(0.5),
                                fontSize: 2.2 * textMultiplier,
                              ),
                            ),
                          ),
                          GetBuilder<ProductController>(
                            builder: (controller){
                              return controller.status.isLoading
                                  ? Flexible(
                                child: Shimmer.fromColors(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
                                          1.5 * heightMultiplier),
                                    ),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 4 * widthMultiplier),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 4 * widthMultiplier),
                                    child: SizeSelectionMenu(
                                        data: product.sizes!),
                                  ),
                                  baseColor: Colors.white,
                                  highlightColor: Colors.grey.shade300,
                                ),
                              )
                                  : Flexible(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Get.theme.accentColor,
                                    borderRadius: BorderRadius.circular(
                                        1.5 * heightMultiplier),
                                  ),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 4 * widthMultiplier),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 4 * widthMultiplier),
                                  child:
                                  SizeSelectionMenu(data: product.sizes!),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    if (product.colors != null)
                      SizedBox(
                        height: 2 * heightMultiplier,
                      ),
                    if (product.colors != null)
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              "colors".tr,
                              style: TextStyle(
                                color:
                                    Get.theme.primaryColorDark.withOpacity(0.5),
                                fontSize: 2.2 * textMultiplier,
                              ),
                            ),
                          ),
                         GetBuilder<ProductController>(
                           builder: (controller){
                             return  controller.status.isLoading
                                 ? Flexible(
                               child: Shimmer.fromColors(
                                 child: Container(
                                   decoration: BoxDecoration(
                                     color: Colors.white,
                                     borderRadius: BorderRadius.circular(
                                         1.5 * heightMultiplier),
                                   ),
                                   margin: EdgeInsets.symmetric(
                                       horizontal: 4 * widthMultiplier),
                                   padding: EdgeInsets.symmetric(
                                       horizontal: 4 * widthMultiplier),
                                   child: ColorSelectionMenu(
                                       data: product.colors!),
                                 ),
                                 baseColor: Colors.white,
                                 highlightColor: Colors.grey.shade300,
                               ),
                             )
                                 : Flexible(
                               child: Container(
                                 decoration: BoxDecoration(
                                   color: Get.theme.accentColor,
                                   borderRadius: BorderRadius.circular(
                                       1.5 * heightMultiplier),
                                 ),
                                 margin: EdgeInsets.symmetric(
                                     horizontal: 4 * widthMultiplier),
                                 padding: EdgeInsets.symmetric(
                                     horizontal: 4 * widthMultiplier),
                                 child: ColorSelectionMenu(
                                     data: product.colors!),
                               ),
                             );
                           },
                         ),
                        ],
                      ),
                    SizedBox(
                      height: 2 * heightMultiplier,
                    ),
                    Text(
                      "description".tr,
                      style: TextStyle(
                        color: Get.theme.primaryColorDark.withOpacity(0.5),
                        fontSize: 2.2 * textMultiplier,
                      ),
                    ),
                    SizedBox(
                      height: heightMultiplier,
                    ),
                    Text(
                      "${product.description}",
                      style: TextStyle(
                        color: Get.theme.primaryColorDark.withOpacity(0.7),
                        fontSize: 2 * textMultiplier,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildLoadingImage() {
    return Shimmer.fromColors(
      child: Container(
        width: double.infinity,
        height: 25 * heightMultiplier,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1.5 * heightMultiplier),
          color: Get.theme.accentColor,
        ),
      ),
      baseColor: Colors.white,
      highlightColor: Colors.grey.shade300,
    );
  }

  _buildLoadingBottomBar() {
    return Shimmer.fromColors(
      child: Container(
        height: 9 * heightMultiplier,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1.5 * heightMultiplier),
          color: Get.theme.accentColor,
        ),
      ),
      baseColor: Colors.white,
      highlightColor: Colors.grey.shade300,
    );
  }
}
