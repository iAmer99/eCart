import 'package:ecart/features/cart/controller/cart_controller.dart';
import 'package:ecart/features/cart/widgets/cart_item.dart';
import 'package:ecart/features/cart/widgets/coupon.dart';
import 'package:ecart/features/cart/widgets/loading_item.dart';
import 'package:ecart/features/shared/widgets/appBar.dart';
import 'package:ecart/utils/helper_functions.dart';
import 'package:ecart/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends GetView<CartController> {
  CartScreen({Key? key}) : super(key: key);
  final TextEditingController _couponController = TextEditingController();
  final FocusNode _node = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        closeKeyboard(context);
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4 * widthMultiplier),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 0.4 * Get.statusBarHeight,
                ),
                MyAppBar(
                  title: Text(
                    "Cart",
                    style: TextStyle(
                      color: Get.theme.primaryColorDark,
                      fontSize: 2.5 * textMultiplier,
                    ),
                  ),
                ),
                SizedBox(
                  height: 2 * heightMultiplier,
                ),
                GetBuilder<CartController>(
                  builder: (controller) {
                    return Expanded(
                      child: Column(
                        children: [
                          if (controller.status.isLoading) LoadingCartItem(),
                          if (controller.status.isSuccess)
                            Expanded(
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ListView(
                                      children: [
                                        ...(controller.cart.cartItems!.map(
                                            (item) =>
                                                CartItemCard(item: item))),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    color: Get.theme.canvasColor,
                                    padding: EdgeInsets.only(
                                        top: 2 * heightMultiplier),
                                    child: Column(
                                      children: [
                                        CouponRow(
                                          couponController: _couponController,
                                          node: _node,
                                        ),
                                        SizedBox(
                                          height: heightMultiplier,
                                        ),
                                        Divider(),
                                        SizedBox(
                                          height: heightMultiplier,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Total Price",
                                                    style: TextStyle(
                                                      color: Get.theme
                                                          .primaryColorDark
                                                          .withOpacity(0.8),
                                                      fontSize:
                                                          2.2 * textMultiplier,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: heightMultiplier,
                                                  ),
                                                  Text(
                                                    "${controller.totalPrice.toString()} EGP",
                                                    style: TextStyle(
                                                      color: Get.theme
                                                          .primaryColorDark
                                                          .withOpacity(0.8),
                                                      fontSize:
                                                          2.2 * textMultiplier,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 4 * widthMultiplier,
                                            ),
                                            Container(
                                              width: 40 * widthMultiplier,
                                              height: 6 * heightMultiplier,
                                              child: ElevatedButton(
                                                onPressed: () {},
                                                child: Text(
                                                  "Checkout",
                                                  style: TextStyle(
                                                    fontSize:
                                                        3 * textMultiplier,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 3 * heightMultiplier,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (controller.status.isEmpty)
                            Expanded(
                              child: Center(
                                child: Text(
                                  "Your Cart is Empty, Start shopping now",
                                  style: TextStyle(
                                    fontSize: 2.5 * textMultiplier,
                                    color: Get.theme.primaryColorDark
                                        .withOpacity(0.7),
                                  ),
                                ),
                              ),
                            ),
                          if (controller.status.isError)
                            Expanded(
                              child: Center(
                                child: Text(
                                  controller.status.errorMessage!,
                                  style: TextStyle(
                                    fontSize: 2.5 * textMultiplier,
                                    color: Get.theme.primaryColorDark
                                        .withOpacity(0.7),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
