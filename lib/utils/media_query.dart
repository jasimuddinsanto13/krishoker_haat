import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockWidth;
  static late double blockHeight;
  static late double textScaleFactor;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockWidth = screenWidth / 100;
    blockHeight = screenHeight / 100;
    textScaleFactor = _mediaQueryData.textScaleFactor;
  }

  // Custom getters
  static double height(double inputHeight) => (inputHeight / 812.0) * screenHeight;
  static double width(double inputWidth) => (inputWidth / 375.0) * screenWidth;
  static double text(double fontSize) => fontSize * textScaleFactor;

  // Orientation
  static Orientation get orientation => _mediaQueryData.orientation;
}
