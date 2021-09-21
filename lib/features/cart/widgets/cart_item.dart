import 'package:ecart/features/cart/controller/cart_controller.dart';
import 'package:ecart/features/cart/repository/model/cart_item.dart';
import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartItemCard extends GetView<CartController> {
  CartItemCard({Key? key, required this.item}) : super(key: key);
  final CartItem item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(1.5 * heightMultiplier),
              child: FadeInImage(
                placeholder: AssetImage("assets/images/default.jpg"),
                image: NetworkImage(item.product!.mainImage!),
                height: 23 * imageSizeMultiplier,
                width: 23 * imageSizeMultiplier,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 2 * widthMultiplier,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product!.name!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      color: Get.theme.primaryColorDark.withOpacity(0.8),
                      fontSize: 2.2 * textMultiplier,
                    ),
                  ),
                  SizedBox(
                    height: heightMultiplier,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          "Color",
                          style: TextStyle(
                            color: Get.theme.primaryColorDark.withOpacity(0.5),
                            fontSize: 1.5 * textMultiplier,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          item.selectedColor!.color!,
                          style: TextStyle(
                            color: Get.theme.primaryColorDark.withOpacity(0.5),
                            fontSize: 1.5 * textMultiplier,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: heightMultiplier,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          "Size",
                          style: TextStyle(
                            color: Get.theme.primaryColorDark.withOpacity(0.5),
                            fontSize: 1.5 * textMultiplier,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          item.selectedSize!.size!,
                          style: TextStyle(
                            color: Get.theme.primaryColorDark.withOpacity(0.5),
                            fontSize: 1.5 * textMultiplier,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: heightMultiplier,
                  ),
                  Text(
                    "${item.totalProductPrice.toString()} EGP",
                    style: TextStyle(
                      color: Get.theme.primaryColorDark.withOpacity(0.8),
                      fontSize: 2.2 * textMultiplier,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: widthMultiplier,
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.decrease(
                                item.product!.id!,
                                item.totalProductQuantity!,
                                item.selectedColor!,
                                item.selectedSize!);
                          },
                          child: Container(
                            height: 7 * imageSizeMultiplier,
                            width: 7 * imageSizeMultiplier,
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
                              size: 5 * imageSizeMultiplier,
                              color: Get.theme.primaryColorDark,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: widthMultiplier,
                        ),
                        Text(
                          item.totalProductQuantity.toString(),
                          style: TextStyle(
                            fontSize: 2.2 * textMultiplier,
                            color: Get.theme.primaryColorDark,
                          ),
                        ),
                        SizedBox(
                          width: widthMultiplier,
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.increase(
                                item.product!.id!,
                                item.selectedColor!,
                                item.selectedSize!);
                          },
                          child: Container(
                            height: 7 * imageSizeMultiplier,
                            width: 7 * imageSizeMultiplier,
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
                              size: 5 * imageSizeMultiplier,
                              color: Get.theme.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextButton.icon(
                      onPressed: () {
                        controller.removeFromCart(item.product!.id!,
                            item.selectedColor!.id!, item.selectedSize!.id!);
                      },
                      icon: Icon(Icons.delete_forever),
                      label: Text("Remove"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Divider()
      ],
    );
  }
}
