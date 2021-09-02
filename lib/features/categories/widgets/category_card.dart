import 'package:ecart/features/shared/models/category.dart';
import 'package:ecart/routes/routes_names.dart';
import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryCard extends StatelessWidget {
  CategoryCard({Key? key, required this.category}) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutesNames.productsScreen, arguments: category);
      },
      child: Container(
        margin: EdgeInsetsDirectional.only(
          bottom: 2 * heightMultiplier,
        ),
        child: Card(
          color: Get.theme.canvasColor,
          elevation: 9,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(1.5 * heightMultiplier)
          ),
          child: Container(
            height: 15 * heightMultiplier,
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(category.name!, style: TextStyle(
                      color: Get.theme.primaryColorDark,
                      fontSize: 2.2 * textMultiplier),),
                  ),),
                Expanded(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    height: 15 * heightMultiplier,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.horizontal(
                          end: Radius.circular(1.5 * heightMultiplier)),
                      // color: Get.theme.primaryColor.withOpacity(0.8)
                      image: DecorationImage(image: _imageProvider(category.image), fit: BoxFit.cover),
                    ),
                  ),
                ),
              ],
            ),
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
