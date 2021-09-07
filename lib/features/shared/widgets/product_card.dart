import 'package:ecart/features/shared/models/product.dart';
import 'package:ecart/routes/routes_names.dart';
import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCard extends StatelessWidget {
  ProductCard({Key? key, required this.product, this.remove}) : super(key: key);
  final Product product;
  final Function(String)? remove;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.toNamed(AppRoutesNames.productDetailsScreen, arguments: product);
      },
      child: Container(
        height: 30 * imageSizeMultiplier,
        width: double.infinity,
        color: Colors.transparent,
        margin: EdgeInsetsDirectional.only(bottom: 1 * heightMultiplier),
        padding: EdgeInsetsDirectional.only(end: widthMultiplier),
        child: Card(
          color: Get.theme.canvasColor,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1.5 * heightMultiplier)
          ),
          child: Row(
            children: [
              Stack(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(1.5 * heightMultiplier),
                      child: FadeInImage(
                        image: _imageProvider(product.mainImage),
                        placeholder: AssetImage("assets/images/default.jpg"),
                        fit: BoxFit.fill,
                        height: 30 * imageSizeMultiplier,
                        width: 30 * imageSizeMultiplier,
                      )),
                  if (product.priceDiscount != null && product.priceDiscount != 0)
                    Padding(
                      padding:
                          EdgeInsetsDirectional.only(top: 3 * imageSizeMultiplier),
                      child: Container(
                        height: 5 * imageSizeMultiplier,
                        width: 15 * imageSizeMultiplier,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.horizontal(
                                end: Radius.circular(1.5 * heightMultiplier)),
                            gradient: LinearGradient(colors: [
                              Get.theme.primaryColor.withOpacity(0.8),
                              Get.theme.primaryColor
                            ])),
                        alignment: Alignment.center,
                        child: Text(
                          "-${product.priceDiscount.toString()}%",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(
                width: 3 * widthMultiplier,
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsetsDirectional.only(top: heightMultiplier),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name!,
                        style: TextStyle(
                          color: Get.theme.primaryColorDark,
                          fontSize: 2 * textMultiplier,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      SizedBox(
                        height: heightMultiplier,
                      ),
                      Text(
                        "${product.priceAfterDiscount!} EGP",
                        style: TextStyle(
                          color: product.priceDiscount != null &&
                                  product.priceDiscount != 0
                              ? Get.theme.primaryColor
                              : Get.theme.primaryColorDark.withOpacity(0.8),
                          fontSize: 2 * textMultiplier,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              if (remove != null)
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: Get.theme.primaryColor,
                    ),
                    onPressed: () {
                      remove!(product.id!);
                    },
                  ),
                ),
            ],
          ),
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
