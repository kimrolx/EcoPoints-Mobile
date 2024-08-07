import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:gap/gap.dart';

import '../../../../components/buttons/custom_elevated_button.dart';
import '../../../../components/constants/colors/ecopoints_colors.dart';
import '../../../../components/constants/text_style/ecopoints_themes.dart';
import '../../../../components/fields/custom_text_form_field.dart';

class ConfirmationCodeRegistrationScreen extends StatelessWidget {
  final Function() onNextPage;
  const ConfirmationCodeRegistrationScreen(
      {super.key, required this.onNextPage});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.only(
        left: width * 0.045,
        right: width * 0.045,
        bottom: height * 0.03,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Enter the confirmation code",
            style: EcoPointsTextStyles.blackTextStyle(
                size: width * 0.045, weight: FontWeight.w600),
          ),
          Gap(height * 0.01),
          Text(
            "To confirm your account, please enter the code we sent to <email here>.",
            style: EcoPointsTextStyles.blackTextStyle(
                size: width * 0.035, weight: FontWeight.normal),
          ),
          Gap(width * 0.04),
          SizedBox(
            child: Flexible(
              child: CustomTextFormField(
                hintText: "Confirmation Code",
                labelText: "Confirmation Code",
                obscureText: false,
                keyboardType: TextInputType.text,
                errorMaxLines: 3,
                // controller: widget.email,
                // focusNode: widget.emailFn,
                // onEditingComplete: () {
                //   widget.passwordFn.requestFocus();
                // },
                validator: MultiValidator([
                  RequiredValidator(
                    errorText: "Password is required",
                  ),
                  MinLengthValidator(
                    8,
                    errorText: "Password must to be at least 8 characters long",
                  ),
                ]).call,
              ),
            ),
          ),
          Gap(width * 0.04),
          CustomElevatedButton(
            onPressed: onNextPage,
            backgroundColor: EcoPointsColors.darkGreen,
            width: width,
            padding: const EdgeInsets.all(10),
            borderRadius: 50.0,
            child: Text(
              "Next",
              style: EcoPointsTextStyles.whiteTextStyle(
                size: width * 0.04,
                weight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
