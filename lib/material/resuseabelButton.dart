import 'package:flutter/material.dart';

class ReuseableContainerButton extends StatelessWidget {
  final Color textcolor;
  final EdgeInsetsGeometry? padding;
  final double height;
  final double width;
  final AlignmentGeometry alignment;
  final Function()? onTap;
  final EdgeInsetsGeometry? labelPadding;
  final String text;
  final List<Color> colors;
  const ReuseableContainerButton(
      {super.key,
      this.padding,
      required this.text,
      required this.textcolor,
      this.onTap,
      this.labelPadding,
      required this.colors,
      required this.alignment,
      required this.height,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: labelPadding,
        alignment: Alignment.center,
        height: height,
        width: width,
        decoration: ShapeDecoration(
          gradient: LinearGradient(begin: alignment, colors: colors),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(27),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 16, color: textcolor, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
