import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../components/constants/colors/ecopoints_colors.dart';
import '../../../../components/fields/custom_text_form_field.dart';
import '../../../../enums/animation_type_enum.dart';
import 'edit_gender.dart';
import 'edit_phone_number.dart';

class UserFieldsProfileScreen extends StatelessWidget {
  final TextEditingController displayNameController;
  final TextEditingController emailController;
  final TextEditingController genderController;
  final TextEditingController numberController;
  final FocusNode numberFn;
  const UserFieldsProfileScreen({
    super.key,
    required this.displayNameController,
    required this.emailController,
    required this.genderController,
    required this.numberController,
    required this.numberFn,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    if (numberController.text.length > 3) {
      numberController.text = numberController.text.substring(3);
    }

    return Container(
      decoration: BoxDecoration(
        color: EcoPointsColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0.5,
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
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
              controller: displayNameController,
              readOnly: true,
            ),
            Gap(height * 0.0125),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        EditGenderProfileScreen(
                      genderController: genderController,
                    ),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return buildPageTransition(
                        child: child,
                        animation: animation,
                        type: AnimationType.slideUp,
                      );
                    },
                    transitionDuration: const Duration(milliseconds: 250),
                  ),
                );
              },
              child: IgnorePointer(
                child: CustomTextFormField(
                  labelText: "Gender",
                  hintText: "Gender",
                  controller: genderController,
                  readOnly: true,
                ),
              ),
            ),
            Gap(height * 0.0125),
            CustomTextFormField(
              labelText: "Email",
              hintText: "Email",
              controller: emailController,
              readOnly: true,
            ),
            Gap(height * 0.0125),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        EditPhoneNumberProfileScreen(
                      numberController: numberController,
                      numberFn: numberFn,
                    ),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return buildPageTransition(
                        child: child,
                        animation: animation,
                        type: AnimationType.slideUp,
                      );
                    },
                    transitionDuration: const Duration(milliseconds: 300),
                  ),
                );
              },
              child: IgnorePointer(
                child: IntlPhoneField(
                  initialCountryCode: 'PH',
                  controller: numberController,
                  focusNode: numberFn,
                  readOnly: true,
                  decoration: InputDecoration(
                    counterText: "",
                    hintText: "910 123 4567",
                    hintStyle: const TextStyle(color: EcoPointsColors.darkGray),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
