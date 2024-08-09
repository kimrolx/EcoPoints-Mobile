import 'package:ecopoints/src/components/misc/custom_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';

import '../../../../components/buttons/custom_elevated_button.dart';
import '../../../../components/constants/colors/ecopoints_colors.dart';
import '../../../../components/constants/text_style/ecopoints_themes.dart';
import '../../../../components/fields/custom_text_form_field.dart';
import '../../../../shared/services/registration_form_service.dart';

class NameFieldsRegistrationScreen extends StatefulWidget {
  final Function() onNextPageClick;
  final Function() onAlreadyHaveAccountClick;
  final bool isLoading;
  const NameFieldsRegistrationScreen(
      {super.key,
      required this.onNextPageClick,
      required this.onAlreadyHaveAccountClick,
      required this.isLoading});

  @override
  State<NameFieldsRegistrationScreen> createState() =>
      _NameFieldsRegistrationScreenState();
}

class _NameFieldsRegistrationScreenState
    extends State<NameFieldsRegistrationScreen> {
  late TextEditingController firstNameController, lastNameController;
  late FocusNode firstNameFn, lastNameFn;
  late GlobalKey<FormState> formKey;
  final RegistrationService _registrationService =
      GetIt.instance<RegistrationService>();

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    var names =
        _registrationService.userProfile.displayName?.split(" ") ?? ["", ""];
    firstNameController =
        TextEditingController(text: names.isNotEmpty ? names[0] : "");
    firstNameFn = FocusNode();
    lastNameController =
        TextEditingController(text: names.isNotEmpty ? names[1] : "");
    lastNameFn = FocusNode();
    firstNameFn.requestFocus();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    firstNameFn.dispose();
    lastNameController.dispose();
    lastNameFn.dispose();
    super.dispose();
  }

  void _handleNext() {
    if (formKey.currentState?.validate() ?? false) {
      _registrationService.updateName(
          firstNameController.text, lastNameController.text);
      widget.onNextPageClick();
    } else {
      print("From NameFieldRegistration - Validation failed");
    }
  }

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
            "What should we call you?",
            style: EcoPointsTextStyles.blackTextStyle(
                size: width * 0.045, weight: FontWeight.w600),
          ),
          Gap(height * 0.01),
          Text(
            "Enter the name you use in real life.",
            style: EcoPointsTextStyles.blackTextStyle(
                size: width * 0.035, weight: FontWeight.normal),
          ),
          Gap(width * 0.03),
          Form(
            key: formKey,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: CustomTextFormField(
                    hintText: "First Name",
                    labelText: "First Name",
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    errorMaxLines: 3,
                    controller: firstNameController,
                    focusNode: firstNameFn,
                    onEditingComplete: () {
                      lastNameFn.requestFocus();
                    },
                    validator: MultiValidator([
                      RequiredValidator(errorText: "First name is required."),
                    ]).call,
                  ),
                ),
                Gap(width * 0.03),
                Flexible(
                  child: CustomTextFormField(
                    hintText: "Last Name",
                    labelText: "Last Name",
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    errorMaxLines: 3,
                    controller: lastNameController,
                    focusNode: lastNameFn,
                    onEditingComplete: () {
                      lastNameFn.unfocus();
                      _handleNext();
                    },
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Last name is required."),
                    ]).call,
                  ),
                ),
              ],
            ),
          ),
          Gap(width * 0.02),
          CustomElevatedButton(
            onPressed: _handleNext,
            backgroundColor: EcoPointsColors.darkGreen,
            width: width,
            padding: const EdgeInsets.all(4),
            borderRadius: 50.0,
            child: widget.isLoading
                ? const CustomCircularProgressIndicator(
                    backgroundColor: Colors.transparent,
                    width: 22.5,
                    height: 22.5)
                : Text(
                    "Next",
                    style: EcoPointsTextStyles.whiteTextStyle(
                      size: width * 0.04,
                      weight: FontWeight.w500,
                    ),
                  ),
          ),
          Expanded(
            child: SafeArea(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  onTap: widget.onAlreadyHaveAccountClick,
                  child: Text(
                    "I already have an account",
                    style: EcoPointsTextStyles.lightGreenTextStyle(
                      size: width * 0.031,
                      weight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
