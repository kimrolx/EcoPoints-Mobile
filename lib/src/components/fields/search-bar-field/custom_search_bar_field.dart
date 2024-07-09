import 'package:ecopoints/src/components/constants/text_style/ecopoints_themes.dart';
import 'package:flutter/material.dart';

class CustomSearchBarField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? autoFocus;
  final FocusNode? focusNode;

  const CustomSearchBarField({
    super.key,
    this.hintText,
    this.controller,
    this.keyboardType,
    this.onFieldSubmitted,
    this.onChanged,
    this.onEditingComplete,
    this.prefixIcon,
    this.suffixIcon,
    this.autoFocus,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        onEditingComplete: onEditingComplete,
        onSubmitted: onFieldSubmitted,
        onChanged: onChanged,
        autofocus: autoFocus ?? false,
        focusNode: focusNode,
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
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        ),
      ),
    );
  }
}
