import 'package:flutter/material.dart';

late double textMultiplier;
late double imageSizeMultiplier;
late double heightMultiplier;
late double widthMultiplier;
bool isPortrait = true;
bool isMobilePortrait = false;

late double _screenWidth;
late double _screenHeight;
double _blockWidth = 0;
double _blockHeight = 0;

void init(BoxConstraints constraints, Orientation orientation) {
  if (orientation == Orientation.portrait) {
    _screenWidth = constraints.maxWidth;
    _screenHeight = constraints.maxHeight;
    isPortrait = true;
    if (_screenWidth < 450) {
      isMobilePortrait = true;
    }
  } else {
    _screenWidth = constraints.maxHeight;
    _screenHeight = constraints.maxWidth;
    isPortrait = false;
    isMobilePortrait = false;
  }

  _blockWidth = _screenWidth / 100;
  _blockHeight = _screenHeight / 100;

  textMultiplier = _blockHeight;
  imageSizeMultiplier = _blockWidth;
  heightMultiplier = _blockHeight;
  widthMultiplier = _blockWidth;

  debugPrint("Bloc height is " + _blockHeight.toString());
  debugPrint("Bloc width is " + _blockWidth.toString());
}
