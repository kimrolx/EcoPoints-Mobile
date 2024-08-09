import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';

import '../../../../components/buttons/custom_elevated_button.dart';
import '../../../../components/constants/colors/ecopoints_colors.dart';
import '../../../../components/constants/text_style/ecopoints_themes.dart';
import '../../../../components/fields/custom_text_form_field.dart';
import '../../../../components/misc/custom_circular_progress_indicator.dart';
import '../../../../shared/services/registration_form_service.dart';

class EmailFieldRegistrationScreen extends StatefulWidget {
  final Function() onNextPage;
  final Function() onAlreadyHaveAccountClick;
  final bool isLoading;
  const EmailFieldRegistrationScreen(
      {super.key,
      required this.onNextPage,
      required this.onAlreadyHaveAccountClick,
      required this.isLoading});

  @override
  State<EmailFieldRegistrationScreen> createState() =>
      _EmailFieldRegistrationScreenState();
}

class _EmailFieldRegistrationScreenState
    extends State<EmailFieldRegistrationScreen> {
  late TextEditingController emailController;
  late FocusNode emailFn;
  late GlobalKey<FormState> formKey;
  final RegistrationService _registrationService =
      GetIt.instance<RegistrationService>();

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    emailFn = FocusNode();
    emailFn.requestFocus();
  }

  @override
  void dispose() {
    emailController.dispose();
    emailFn.dispose();
    super.dispose();
  }

  void _handleNext() {
    if (formKey.currentState?.validate() ?? false) {
      _registrationService.updateEmail(emailController.text);
      widget.onNextPage();
    } else {
      print("From EmailFieldRegistration - Validation failed");
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
            "What's your email?",
            style: EcoPointsTextStyles.blackTextStyle(
                size: width * 0.045, weight: FontWeight.w600),
          ),
          Gap(height * 0.01),
          Text(
            "Enter the email where you want to be contacted.",
            style: EcoPointsTextStyles.blackTextStyle(
                size: width * 0.035, weight: FontWeight.normal),
          ),
          Gap(width * 0.03),
          Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: CustomTextFormField(
                    hintText: "Email",
                    labelText: "Email",
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    errorMaxLines: 3,
                    controller: emailController,
                    focusNode: emailFn,
                    onEditingComplete: () {
                      emailFn.unfocus();
                      _handleNext();
                    },
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Email is required."),
                      EmailValidator(errorText: "Enter a valid email address"),
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
