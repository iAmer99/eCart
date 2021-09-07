import 'package:ecart/features/shared/models/product.dart';
import 'package:ecart/routes/routes_names.dart';
import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeProduct extends StatelessWidget {
  const HomeProduct({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.toNamed(AppRoutesNames.productDetailsScreen, arguments: product);
      },
      child: Container(
        margin: EdgeInsetsDirectional.only(
            top: .6 * heightMultiplier,
            bottom: .6 * heightMultiplier,
            end: 2.5 * widthMultiplier),
        child: Stack(
          children: [
            Column(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(1.5 * heightMultiplier),
                    child: FadeInImage(
                      image: _imageProvider(product.mainImage),
                      placeholder: AssetImage("assets/images/default.jpg"),
                      fit: BoxFit.fill,
                      height: 31 * imageSizeMultiplier,
                      width: 31 * imageSizeMultiplier,
                    )),
                SizedBox(height: heightMultiplier),
                Container(
                  alignment: Alignment.center,
                  width: 31 * imageSizeMultiplier,
                  height: 5 * heightMultiplier,
                  child: Text(
                    product.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Get.theme.primaryColorDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 1.5 * textMultiplier,
                    ),
                  ),
                ),
                SizedBox(height: heightMultiplier,),
                Container(
                  alignment: AlignmentDirectional.centerStart,
                  width: 31 * imageSizeMultiplier,
                  child: Text("${product.priceAfterDiscount!}EGP",
                    style: TextStyle(
                      color: product.priceDiscount != null &&
                          product.priceDiscount != 0 ? Get.theme.primaryColor : Get.theme.primaryColorDark
                          .withOpacity(0.8),
                      fontWeight: FontWeight.bold,
                      fontSize: 1.5 * textMultiplier,
                    ),
                  ),
                ),
                SizedBox(height: heightMultiplier,),
                Container(
                    width: 31 * widthMultiplier,
                    height: 5 * heightMultiplier,
                    margin: EdgeInsetsDirectional.only(
                        bottom: 1 * heightMultiplier),
                    child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "Buy Now",
                          style: TextStyle(fontSize: 2 * textMultiplier),
                        ))),
              ],
            ),
            if(product.priceDiscount != null &&
                product.priceDiscount != 0)  Padding(
              padding: EdgeInsetsDirectional.only(top: 3 * imageSizeMultiplier),
              child: Container(
                height: 5 * imageSizeMultiplier,
                width: 15 * imageSizeMultiplier,
                decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.horizontal(end: Radius.circular(1.5 * heightMultiplier)),
                    gradient: LinearGradient(
                        colors: [
                          Get.theme.primaryColor.withOpacity(0.8),
                          Get.theme.primaryColor
                        ]
                    )
                ),
                alignment: Alignment.center,
                child: Text("-${product.priceDiscount.toString()}%", style: TextStyle(color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ImageProvider _imageProvider(String? image) {
    if (image != null) {
      return NetworkImage(image);
    } else {
      return AssetImage("assets/images/default.jpg");
    }
  }
}
