import 'dart:async';

import 'package:ecart/core/session_management.dart';
import 'package:ecart/features/home/controller/home_controller.dart';
import 'package:ecart/features/home/widgets/categoriesSlider.dart';
import 'package:ecart/features/home/widgets/cheapestProducts.dart';
import 'package:ecart/features/home/widgets/popularProducts.dart';
import 'package:ecart/features/home/widgets/saleBanner.dart';
import 'package:ecart/features/shared/widgets/appBar.dart';
import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
   HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController controller = Get.find<HomeController>();
  @override
  void initState() {
   if(SessionManagement.isUser){
     if(DateTime.parse(SessionManagement.expiryDate!).isAfter(DateTime.now())){
       Duration difference = DateTime.parse(SessionManagement.expiryDate!).difference(DateTime.now());
       Timer(Duration(seconds: difference.inSeconds), (){
         controller.checkTokenValidity().then((_){
           Timer.periodic(Duration(minutes: 28), (_){
             controller.checkTokenValidity();
           });
         });
       });
     }else {
       Timer.periodic(Duration(minutes: 28), (_){
         controller.checkTokenValidity();
       });
     }
   }
    super.initState();
  }

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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4 * widthMultiplier),
            child: Column(
              children: [
                SizedBox(
                  height: Get.statusBarHeight * 0.4,
                ),
                MyAppBar(
                  hideBack: true,
                ),
                Expanded(
                  child: ListView(
                    children: [
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
