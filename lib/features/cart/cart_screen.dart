import 'package:ecart/core/session_management.dart';
import 'package:ecart/features/cart/controller/cart_controller.dart';
import 'package:ecart/features/cart/widgets/cart_item.dart';
import 'package:ecart/features/cart/widgets/coupon.dart';
import 'package:ecart/features/cart/widgets/loading_item.dart';
import 'package:ecart/features/shared/widgets/appBar.dart';
import 'package:ecart/features/shared/widgets/mustLogin.dart';
import 'package:ecart/routes/routes_names.dart';
import 'package:ecart/utils/helper_functions.dart';
import 'package:ecart/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends GetView<CartController> {
  CartScreen({Key? key}) : super(key: key);
  final FocusNode _node = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        closeKeyboard(context);
      },
      child: Scaffold(
        body: SafeArea(
          child: SessionManagement.isGuest ? MustLogin(hideCart: true, title: Container(),) :  Padding(
            padding: EdgeInsets.symmetric(horizontal: 4 * widthMultiplier),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 0.4 * Get.statusBarHeight,
                ),
                MyAppBar(
                  title: Text(
                    "cart".tr,
                    style: TextStyle(
                      color: Get.theme.primaryColorDark,
                      fontSize: 2.5 * textMultiplier,
                    ),
                  ),
                  hideCart: true,
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
                                      if(context.orientation == Orientation.landscape )  _buildBottomSheet(controller),
                                      ],
                                    ),
                                  ),
                                  if(context.orientation == Orientation.portrait )  _buildBottomSheet(controller),
                                ],
                              ),
                            ),
                          if (controller.status.isEmpty)
                            Expanded(
                              child: Center(
                                child: Text(
                                  "empty_cart".tr,
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

  Container _buildBottomSheet(CartController controller) {
    return Container(
                                  color: Get.theme.canvasColor,
                                  padding: EdgeInsets.only(
                                      top: 2 * heightMultiplier),
                                  child: Column(
                                    children: [
                                      CouponRow(
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
                                                  "total_price".tr,
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
                                                  "price".trParams({
                                                    "price" : controller.totalPrice.toStringAsFixed(2),
                                                  }),
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
                                              onPressed: () {
                                                Get.toNamed(AppRoutesNames.checkoutScreen);
                                              },
                                              child: Text(
                                                "checkout".tr,
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
                                );
  }
}
