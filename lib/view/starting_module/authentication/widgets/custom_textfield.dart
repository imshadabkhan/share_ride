import 'package:flutter/material.dart';

// ignore: must_be_immutable
class textField extends StatelessWidget {
  textField({
    super.key,
    this.controller,
    this.onTap,
    this.icon,
    this.maxlength,
    this.hintText,
    this.suffixicon,
    this.suffixiconcolor,
    this.fillcolor,
    this.keyboardType,
    this.validator,
    this.contentPadding,
    this.onChanged,

  });

  var validator;
  var controller;
  var contentPadding;
  var fillcolor;
  var icon;
  var maxlength;
  var hintText;
  var suffixicon;
  var suffixiconcolor;
  var keyboardType;
  final void Function()? onTap;
  final void Function(String)? onChanged;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
onChanged: onChanged,
      validator: validator,
      controller: controller,
      onTap: onTap,
      keyboardType: keyboardType,
      maxLength: maxlength,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        counterText: '',
        contentPadding: contentPadding,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xffFF8B05),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Color(0xffE4E4E4),
          ),
        ),
        fillColor: fillcolor,
        prefixIcon: icon,
        suffixIcon: suffixicon,
        suffixIconColor: suffixiconcolor,
        hintText: hintText,
        hintStyle: TextStyle(
            // fontSize: 12.sp,
            ),
        filled: true,
      ),
    );
  }
}
