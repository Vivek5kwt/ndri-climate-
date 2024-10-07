import 'package:flutter/material.dart';

class ResponsiveUtils {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;

  static late double _safeAreaHorizontal;
  static late double _safeAreaVertical;
  static late double safeBlockHorizontal;
  static late double safeBlockVertical;

  static bool isTablet = false;

  /// This scale factor is used to make elements slightly larger on tablets.
  static double scaleFactor = 1.0;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;

    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;

    // Determine if the device is a tablet
    isTablet = _isTablet();

    // Adjust scaleFactor based on device type
    scaleFactor = isTablet ? 1.2 : 1.0;
  }

  static double hp(double percentage) {
    return blockSizeVertical * percentage * scaleFactor;
  }

  static double wp(double percentage) {
    return blockSizeHorizontal * percentage * scaleFactor;
  }

  /// Determines if the current device is a tablet based on its size.
  bool _isTablet() {
    // Tablets typically have a diagonal screen size of 7 inches or more.
    // We use a common heuristic where a tablet has a width of at least 600dp.
    double shortestSide = _mediaQueryData.size.shortestSide;
    return shortestSide >= 600;
  }
}
