import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ndri_climate/material/plugin/responsiveUtils.dart';

class Reusabledescription extends StatelessWidget {
  final String desciption;
  final TextStyle? textStyle;

  const Reusabledescription({
    super.key,
    required this.desciption,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(top: 4),
            width: ResponsiveUtils.wp(3.5),
            height: ResponsiveUtils.wp(3.5),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/icon/tick.webp'),
              ),
            ),
          ),
          SizedBox(width: ResponsiveUtils.wp(2)),
          Expanded(
            child: Text(
              desciption.tr,
              style: textStyle ??
                  TextStyle(
                    fontSize: ResponsiveUtils.wp(3),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
