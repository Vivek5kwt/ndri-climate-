import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ndri_climate/material/plugin/responsiveUtils.dart';

class ReusableContainer extends StatelessWidget {
  final String title;
  final String image;
  final Function()? onTap;
  final double? width; // Add this line

  const ReusableContainer({
    super.key,
    required this.title,
    required this.image,
    required this.onTap,
    this.width, // Add this line
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.only(bottom: 15),
        alignment: Alignment.bottomCenter,
        height: ResponsiveUtils.hp(20),
        width: width ?? ResponsiveUtils.wp(38), // Use the passed width or default
        margin: EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            filterQuality: FilterQuality.high,
            opacity: 0.8,
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
        ),
        child: AutoSizeText(
          maxFontSize: 16,
          minFontSize: 12,
          title.tr,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: ResponsiveUtils.wp(3.2),
            fontWeight: FontWeight.w800,
            color: Colors.white,
            shadows: [
              Shadow(
                blurRadius: 10.0,
                color: Colors.black,
                offset: Offset(2.0, 2.0),
              ),
            ],
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
