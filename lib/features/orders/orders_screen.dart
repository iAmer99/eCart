import 'package:ecart/features/orders/controller/orders_controller.dart';
import 'package:ecart/features/orders/widgets/loadingOrderCard.dart';
import 'package:ecart/features/orders/widgets/order_card.dart';
import 'package:ecart/features/shared/widgets/appBar.dart';
import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class OrdersScreen extends GetView<OrdersController> {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async{
        await controller.getOrders();
      },
      child: Scaffold(
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async{
              controller.getOrders();
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 4 * widthMultiplier,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: Get.statusBarHeight * 0.4,
                  ),
                  MyAppBar(
                    hideCart: true,
                    title: Text(
                      "my_orders".tr,
                      style: TextStyle(
                        color: Get.theme.primaryColorDark,
                        fontSize: 2.5 * textMultiplier,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3 * heightMultiplier,
                  ),
                  GetBuilder<OrdersController>(
                    builder: (controller) {
                      return Expanded(
                        child: LazyLoadScrollView(
                          onEndOfPage: () {
                            controller.loadNextPage();
                            controller.getOrders();
                          },
                          isLoading: controller.lastPage,
                          child: Column(
                            children: [
                              if (controller.status.isEmpty)
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      "no_orders".tr,
                                      style: TextStyle(
                                          color: Get.theme.primaryColorDark,
                                          fontSize: 2.2 * textMultiplier),
                                    ),
                                  ),
                                ),
                              if (controller.status.isLoading)
                                Expanded(
                                  child: ListView(
                                    children: [
                                      for (var i = 0; i < 10; i++)
                                        LoadingOrderCard(),
                                    ],
                                  ),
                                ),
                              if (controller.status.isSuccess)
                                Expanded(
                                  child: ListView(
                                    children: [
                                      ...(controller.orders.map((order) {
                                        return OrderCard(
                                          order: order,
                                          index: controller.orders.indexOf(order),
                                        );
                                      })),
                                      if (controller.status.isLoadingMore)
                                        LoadingOrderCard(),
                                    ],
                                  ),
                                )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
