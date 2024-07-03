import 'package:ecopoints/src/components/constants/colors/ecopoints_colors.dart';
import 'package:ecopoints/src/components/fields/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class UserFieldsProfileScreen extends StatelessWidget {
  final TextEditingController displayName;
  final TextEditingController email;
  final TextEditingController gender;
  final TextEditingController number;
  const UserFieldsProfileScreen({
    super.key,
    required this.displayName,
    required this.email,
    required this.gender,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    print("GEnder: $gender Phone number: $number");

    return Card(
      color: EcoPointsColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 8.5,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.03,
          vertical: height * 0.02,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextFormField(
              labelText: "Name",
              hintText: "Name",
              controller: displayName,
              readOnly: true,
            ),
            Gap(height * 0.0125),
            CustomTextFormField(
              labelText: "Gender",
              hintText: "Gender",
              controller: gender,
              readOnly: true,
            ),
            Gap(height * 0.0125),
            CustomTextFormField(
              labelText: "Email",
              hintText: "Email",
              controller: email,
              readOnly: true,
            ),
            Gap(height * 0.0125),
            CustomTextFormField(
              labelText: "Phone Number",
              hintText: "Phone Number",
              controller: number,
              readOnly: true,
            ),
          ],
        ),
      ),
    );
  }
}
