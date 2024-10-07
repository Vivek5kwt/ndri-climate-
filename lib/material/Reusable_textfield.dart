
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ndri_climate/material/plugin/responsiveUtils.dart';

// ignore: must_be_immutable
class ReusableField extends StatelessWidget {
  final Color hinttextcolor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? height;
  final double? width;
  final Color? fillcolor;
  bool color = false;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final String? initialValue;
  final Function()? onTap;
  final Function(String)? onChanged;
  final String lable;
  final String hinttext;
  final bool? readonly;
  Widget? suffixIcon;
  final int? maxlength;
  final bool CircleBorder;
  final TextInputType textInputType;
  ReusableField(
      {super.key,
      this.controller,
      this.suffixIcon,
      required this.lable,
      required this.textInputType,
      this.maxlength,
      required this.color,
      this.validator,
      this.onChanged,
      required this.hinttextcolor,
      this.initialValue,
      this.fillcolor,
      this.readonly,
      this.onTap,
      required this.hinttext,
      this.padding,
      this.margin,
      this.height,
      this.width,
      required this.CircleBorder});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: height,
      width: width,
      margin: margin,
      padding: padding,

      child: TextFormField(
        validator: validator,
        onChanged: onChanged,
        onTap: onTap,
        showCursor: true,
        mouseCursor: MouseCursor.uncontrolled,
        maxLength: maxlength,
        readOnly: readonly ?? false,
        controller: controller,
        autocorrect: true,
        keyboardType: textInputType,
        initialValue: initialValue,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          filled: true,
          fillColor: color ? Color(0xffF3F3F3) : Colors.transparent,
          suffixIcon: suffixIcon,
          hintText: hinttext,
          hintStyle: GoogleFonts.lexend(
              color: hinttextcolor,
              fontSize: ResponsiveUtils.wp(2.5),
              fontWeight: FontWeight.w400,
              letterSpacing: -0.3),
          focusedBorder: CircleBorder
              ? OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF2C96D2).withOpacity(0.5), width: 0.5),
                  borderRadius: BorderRadius.circular(20),
                )
              : OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF2C96D2).withOpacity(0.5), width: 0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
          enabledBorder: CircleBorder
              ? OutlineInputBorder(
                
                  borderSide: BorderSide(color: Color(0xFF2C96D2).withOpacity(0.5), width: 0.5),
                  borderRadius: BorderRadius.circular(20),
                )
              : OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF2C96D2).withOpacity(0.5), width: 0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
          border: OutlineInputBorder(
            
            borderSide: BorderSide(color: Color(0xFF2C96D2).withOpacity(0.5), width: 0.5),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        cursorColor: Colors.black54,
        cursorWidth: 0.8,
      ),
    );
  }
}