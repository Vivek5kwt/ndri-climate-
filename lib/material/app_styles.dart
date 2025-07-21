import 'package:flutter/material.dart';
import 'package:ndri_climate/material/plugin/responsiveUtils.dart';

class AppStyles {
  AppStyles._();

  static TextStyle get tabTextStyle => TextStyle(
        fontSize: ResponsiveUtils.wp(4),
        fontWeight: FontWeight.bold,
      );

  static TextStyle get sectionTitleStyle => TextStyle(
        fontSize: ResponsiveUtils.wp(5),
        fontWeight: FontWeight.bold,
        color: const Color(0xFF1976D2),
      );

  static TextStyle get subtitleTextStyle => TextStyle(
        fontSize: ResponsiveUtils.wp(3.5),
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      );
}
