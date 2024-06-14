import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ReuseableFeild extends StatelessWidget {
  final Color hinttextcolor;
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
  final TextInputType textInputType;
  ReuseableFeild(
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
      required this.hinttext});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
      style: TextStyle(color: hinttextcolor),
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        label: Text(lable),
        labelStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w700, fontSize: 12),
        hintText: hinttext,
        hintStyle: TextStyle(color: hinttextcolor),
        fillColor: color ? fillcolor : Colors.grey.withOpacity(0.2),
        focusColor: Colors.green,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 66, 254, 72)),
          borderRadius: BorderRadius.circular(28),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
          borderRadius: BorderRadius.circular(28),
        ),
      ),
      cursorColor: Colors.black54,
      cursorWidth: 0.8,
    );
  }
}
