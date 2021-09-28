import 'package:ecart/features/search/controller/search_controller.dart';
import 'package:ecart/features/shared/widgets/appBar.dart';
import 'package:ecart/features/shared/widgets/loadingProductCard.dart';
import 'package:ecart/features/shared/widgets/product_card.dart';
import 'package:ecart/features/shared/widgets/sort_selection.dart';
import 'package:ecart/utils/helper_functions.dart';
import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final FocusNode _node = FocusNode();
  String _input = "";

  @override
  void initState() {
    _node.requestFocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchController>(
      builder: (controller) {
        return GestureDetector(
          onTap: () {
            closeKeyboard(context);
          },
          child: Scaffold(
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4 * widthMultiplier),
                child: LazyLoadScrollView(
                  onEndOfPage: (){
                    controller.loadNextPage();
                    controller.search(_input);
                  },
                  isLoading: controller.lastPage,
                  child: Column(
                    children: [
                      SizedBox(
                        height: Get.statusBarHeight * 0.4,
                      ),
                      MyAppBar(
                        node: _node,
                        onChange: (String input) {
                          setState(() {
                            _input = input;
                          });
                          controller.search(input);
                        },
                      ),
                      SizedBox(
                        height: heightMultiplier,
                      ),
                      if(!controller.isInitial) SortSelection(onSelection: (index){
                        controller.getSorting(index);
                        controller.search(_input);
                      },),
                      if (controller.isInitial)
                        Expanded(
                          child: Center(
                              child: SvgPicture.asset(
                                "assets/svg/search.svg",
                                height: 60 * imageSizeMultiplier,
                              )),
                        ),
                      if(controller.status != null && controller.status!.isLoading)
                        LoadingProductCard(),
                      if (controller.status != null && controller.status!.isEmpty)
                        Expanded(
                          child: Center(
                            child: Text(
                              "no_products".tr,
                              style: TextStyle(
                                  color: Get.theme.primaryColorDark,
                                  fontSize: 2.2 * textMultiplier),
                            ),
                          ),
                        ),
                      if (controller.status != null && controller.status!.isError)
                        Expanded(
                          child: Center(
                            child: Text(
                              controller.status!.errorMessage!,
                              style: TextStyle(
                                  color: Get.theme.primaryColorDark,
                                  fontSize: 2.2 * textMultiplier),
                            ),
                          ),
                        ),
                      if (controller.status != null && controller.status!.isSuccess)
                        Expanded(
                          child: ListView(
                            children: [
                              ...(controller.products.map((product){
                                return ProductCard(product: product,);
                              })),
                              if(controller.status!.isLoadingMore)
                                LoadingProductCard(),
                            ],
                          ),
                        ),
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
}
