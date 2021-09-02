import 'package:ecart/features/categories/categories_screen.dart';
import 'package:ecart/features/favourites/favourites_screen.dart';
import 'package:ecart/features/home/home_screen.dart';
import 'package:ecart/features/more/more_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomBarScreen extends StatefulWidget {
  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
         if(index == 0) HomeScreen(),
          if(index == 1) CategoriesScreen(),
          if(index == 2) FavouritesScreen(),
          if(index == 3) MoreScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home",),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: "Categories",),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favourites",),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "More",),
        ],
        onTap: (index) {
          setState(() {
            this.index = index;
          });
        },
      ),
    );
  }
}