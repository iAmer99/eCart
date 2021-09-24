import 'package:ecart/utils/colors.dart';
import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';

class Themes {
  static ThemeMode lightMode = ThemeMode.light;
  static ThemeMode darkMode = ThemeMode.dark;

  static ThemeData lightTheme = ThemeData(
      primaryColor: mainColor,
      primarySwatch: mainColorSwatch,
      accentColor: accentColor,
      primaryColorLight: Colors.white,
      primaryColorDark: Colors.black,
      canvasColor: Colors.white,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.black,
        selectedItemColor: mainColor,
        unselectedItemColor: Colors.black,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(mainColor),
              shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(1.5 * heightMultiplier),
              ))
          )
      )
  );
  static ThemeData darkTheme = ThemeData(
      primaryColor: mainColor,
      primarySwatch: mainColorSwatch,
      accentColor: accentColor.withOpacity(0.4),
      primaryColorLight: Colors.black,
      primaryColorDark: Colors.white,
      canvasColor: Color(0xff16202a),
      textTheme: TextTheme(
        subtitle1: TextStyle(
          color: Colors.white70,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: mainColor,
        unselectedItemColor: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(mainColor),
              shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(1.5 * heightMultiplier),
              ))
          )
      )
  );
}
