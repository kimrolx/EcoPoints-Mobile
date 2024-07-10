import 'package:flutter/material.dart';

import '../constants/text_style/ecopoints_themes.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final bool? obscureText;
  final bool? readOnly;
  final int? errorMaxLines;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final Widget? suffixIcon;
  const CustomTextFormField({
    super.key,
    this.hintText,
    this.labelText,
    this.obscureText,
    this.focusNode,
    this.controller,
    this.validator,
    this.keyboardType,
    this.onFieldSubmitted,
    this.onChanged,
    this.onEditingComplete,
    this.suffixIcon,
    this.errorMaxLines,
    this.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText ?? false,
      onEditingComplete: onEditingComplete,
      keyboardType: keyboardType,
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      focusNode: focusNode,
      readOnly: readOnly ?? false,
      style: EcoPointsTextStyles.blackTextStyle(
        size: 16.0,
        weight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        isDense: true,
        hintText: hintText,
        hintStyle: EcoPointsTextStyles.grayTextStyle(
          size: 16.0,
          weight: FontWeight.w500,
        ),
        // labelText: controller!.text.isNotEmpty && controller != null
        //     ? labelText
        //     : null,
        labelStyle: EcoPointsTextStyles.blackTextStyle(
          size: 16.0,
          weight: FontWeight.w500,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorMaxLines: errorMaxLines,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
