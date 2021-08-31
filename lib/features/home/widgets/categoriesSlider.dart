import 'package:ecart/features/home/controller/home_controller.dart';
import 'package:ecart/features/shared/models/category.dart';
import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CategoriesSlider extends StatelessWidget {
  const CategoriesSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Categories",
                style: TextStyle(
                    color: Get.theme.primaryColorDark.withOpacity(0.7),
                    fontSize: 2.2 * textMultiplier),
              ),
              TextButton(onPressed: () {}, child: Text("See All")),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: _items(controller),
          )
        ],
      );
    });
  }

 Widget _items(HomeController controller){
    if(controller.categoryStatus.isLoading){
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: _buildLoading(),
      );
    }else if(controller.categoryStatus.isEmpty){
      return Center(child: Text("No Categories Found", style: TextStyle(color: Get.theme.primaryColorDark),),);
    }else if(controller.categoryStatus.isSuccess){
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: _buildCategories(controller.categories!),
      );
    }else{
      return Center(child: Text(controller.categoryStatus.errorMessage!, style: TextStyle(color: Get.theme.primaryColorDark),),);
    }
  }

  List<Widget> _buildCategories(List<Category> categories) {
    return categories.map((category) {
      return Container(
        margin: EdgeInsetsDirectional.only(
            top: .6 * heightMultiplier,
            bottom: .6 * heightMultiplier,
            end: 2 * widthMultiplier),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(1.5 * heightMultiplier),
                child: FadeInImage(
                  image: _imageProvider(category.image),
                  placeholder: AssetImage("assets/images/default.jpg"),
                  fit: BoxFit.fill,
                  height: 23 * imageSizeMultiplier,
                  width: 23 * imageSizeMultiplier,
                )),
            SizedBox(height: heightMultiplier),
            Container(
              alignment: Alignment.center,
              child: Text(
                category.name!,
                style: TextStyle(
                  color: Get.theme.primaryColorDark,
                  fontWeight: FontWeight.bold,
                  fontSize: 2 * textMultiplier,
                ),
              ),
            )
          ],
        ),
      );
    }).toList();
  }

  ImageProvider _imageProvider(String? image) {
    if (image != null) {
      return NetworkImage(image);
    } else {
      return AssetImage("assets/images/default.jpg");
    }
  }

  List<Widget> _buildLoading() {
    return [
      for (var i = 0; i < 7; i++)
        Shimmer.fromColors(
          baseColor: Colors.white,
          highlightColor: Colors.grey.shade300,
          child: Container(
            margin: EdgeInsetsDirectional.only(
                top: .6 * heightMultiplier,
                bottom: .6 * heightMultiplier,
                end: 2 * widthMultiplier),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(1.5 * heightMultiplier),
                  child: Container(
                    width: 23 * imageSizeMultiplier,
                    height: 23 * imageSizeMultiplier,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: heightMultiplier),
                Container(
                  height: 2.5 * heightMultiplier,
                  color: Get.theme.canvasColor,
                )
              ],
            ),
          ),
        )
    ];
  }
}
