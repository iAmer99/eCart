import 'package:ecart/features/categories/controller/categories_controller.dart';
import 'package:ecart/features/categories/widgets/category_card.dart';
import 'package:ecart/features/shared/models/category.dart';
import 'package:ecart/features/shared/widgets/appBar.dart';
import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:shimmer/shimmer.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({Key? key}) : super(key: key);
  final Category category = Category();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoriesController>(
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: () async{
                controller.getCategories();
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4 * widthMultiplier),
                child: LazyLoadScrollView(
                  onEndOfPage: (){
                    controller.loadNextPage();
                    controller.getCategories();
                  },
                  isLoading: controller.lastPage,
                  child: Column(
                    children: [
                      SizedBox(
                        height: Get.statusBarHeight * 0.4,
                      ),
                      MyAppBar(),
                      SizedBox(
                        height: 2 * heightMultiplier,
                      ),
                      if (controller.categoryStatus.isEmpty)
                        Expanded(
                            child: Center(
                          child: Text(
                            "No Categories Found",
                            style: TextStyle(
                                color: Get.theme.primaryColorDark,
                                fontSize: 2.2 * textMultiplier),
                          ),
                        )),
                      if (controller.categoryStatus.isSuccess)
                       Expanded(
                         child: ListView(
                           children: [
                             ...(controller.categories.map((category){
                               return CategoryCard(category: category);
                             })),
                             if(controller.categoryStatus.isLoadingMore)
                               _buildLoading(),
                           ],
                         ),
                       ),
                      if (controller.categoryStatus.isError)
                        Expanded(
                            child: Center(
                          child: Text(
                            controller.categoryStatus.errorMessage!,
                            style: TextStyle(
                                color: Get.theme.primaryColorDark,
                                fontSize: 2.2 * textMultiplier),
                          ),
                        )),
                      if(controller.categoryStatus.isLoading)
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                for(var i = 0; i < 7; i++)
                                _buildLoading()
                              ],
                            ),
                          ),
                        )

                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  _buildLoading() {
    return Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: Colors.grey.shade300,
        child: Container(
          margin: EdgeInsetsDirectional.only(
              bottom: 2 * heightMultiplier,
              ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(1.5 * heightMultiplier),
            child: Container(
              width: double.infinity,
              height: 15 * heightMultiplier,
              color: Colors.white,
            ),
          ),
        ),
      );
  }
}
