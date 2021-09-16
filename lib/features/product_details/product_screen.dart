import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecart/core/session_management.dart';
import 'package:ecart/features/product_details/controller/product_controller.dart';
import 'package:ecart/features/product_details/widgets/image_indicator.dart';
import 'package:ecart/features/shared/models/product.dart';
import 'package:ecart/features/shared/widgets/appBar.dart';
import 'package:ecart/routes/routes_names.dart';
import 'package:ecart/utils/helper_functions.dart';
import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

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
                        Container(
                            height: 8 * heightMultiplier,
                            margin: EdgeInsetsDirectional.only(
                                bottom: heightMultiplier,
                                top: heightMultiplier),
                            child: ElevatedButton(
                                onPressed: () {
                                  if (SessionManagement.isUser) {
                                    if(product.isOutOfStock == true){
                                      showSnackBar("Product is out if stock");
                                    }
                                    else if (controller.addedToCart.isFalse) {
                                      controller.addToCart();
                                    } else {
                                      Get.toNamed(AppRoutesNames.cartScreen);
                                    }
                                  } else {
                                    Get.toNamed(AppRoutesNames.registerScreen);
                                  }
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      controller.addedToCart.value
                                          ? Colors.blueGrey
                                          : Get.theme.primaryColor),
                                ),
                                child: Text(
                                  controller.addedToCart.value
                                      ? "Checkout"
                                      : "Add to Cart",
                                  style:
                                      TextStyle(fontSize: 3.6 * textMultiplier),
                                ))),
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
                                                  fit: BoxFit.cover,
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
                          "${product.priceAfterDiscount!} EGP",
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
                            "${product.price!} EGP",
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
                            "Out Of Stock",
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
                            "Product",
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
                              "Reviews",
                              style: TextStyle(
                                  color: Get.theme.primaryColorDark
                                      .withOpacity(0.8),
                                  fontSize: 2.2 * textMultiplier),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (product.size != null)
                      SizedBox(
                        height: 2 * heightMultiplier,
                      ),
                    if (product.size != null)
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              "Sizes",
                              style: TextStyle(
                                color:
                                    Get.theme.primaryColorDark.withOpacity(0.5),
                                fontSize: 2.2 * textMultiplier,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              "${product.size}",
                              style: TextStyle(
                                color:
                                    Get.theme.primaryColorDark.withOpacity(0.7),
                                fontSize: 2.2 * textMultiplier,
                              ),
                            ),
                          ),
                        ],
                      ),
                    if (product.color != null)
                      SizedBox(
                        height: 2 * heightMultiplier,
                      ),
                    if (product.color != null)
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              "Colors",
                              style: TextStyle(
                                color:
                                    Get.theme.primaryColorDark.withOpacity(0.5),
                                fontSize: 2.2 * textMultiplier,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              "${product.color}",
                              style: TextStyle(
                                color:
                                    Get.theme.primaryColorDark.withOpacity(0.7),
                                fontSize: 2.2 * textMultiplier,
                              ),
                            ),
                          ),
                        ],
                      ),
                    SizedBox(
                      height: 2 * heightMultiplier,
                    ),
                    Text(
                      "Description",
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
