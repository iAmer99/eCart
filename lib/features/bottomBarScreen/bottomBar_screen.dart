import 'package:ecart/features/categories/categories_screen.dart';
import 'package:ecart/features/favourites/favourites_screen.dart';
import 'package:ecart/features/home/home_screen.dart';
import 'package:ecart/features/more/more_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class BottomBarScreen extends StatefulWidget {
  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int index = 0;
  List<int> lastIndex = [0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (index == 0) HomeScreen(),
          if (index == 1)
            WillPopScope(
              onWillPop: () async {
                setState(() {
                  index = lastIndex.last;
                  lastIndex.remove(lastIndex.last);
                });
                return false;
              },
              child: CategoriesScreen(),
            ),
          if (index == 2)
            WillPopScope(
              onWillPop: () async {
                setState(() {
                  index = lastIndex.last;
                  lastIndex.remove(lastIndex.last);
                });
                return false;
              },
              child: FavouritesScreen(),
            ),
          if (index == 3)
            WillPopScope(
              onWillPop: () async {
                setState(() {
                  index = lastIndex.last;
                  lastIndex.remove(lastIndex.last);
                });
                return false;
              },
              child: MoreScreen(),
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/svg/categories.svg', color: index == 1 ? Get.theme.primaryColor : Get.theme.bottomNavigationBarTheme.unselectedItemColor, height: Get.theme.iconTheme.size,),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favourites",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: "More",
          ),
        ],
        onTap: (index) {
          setState(() {
            this.index = index;
            if (index != 0) this.lastIndex.add(index);
          });
        },
      ),
    );
  }
}
