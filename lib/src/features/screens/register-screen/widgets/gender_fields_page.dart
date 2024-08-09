import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';

import '../../../../components/buttons/custom_elevated_button.dart';
import '../../../../components/constants/colors/ecopoints_colors.dart';
import '../../../../components/constants/text_style/ecopoints_themes.dart';
import '../../../../components/misc/custom_circular_progress_indicator.dart';
import '../../../../shared/services/registration_form_service.dart';

class GenderFieldsRegistrationScreen extends StatefulWidget {
  final Function() onNextPage;
  final Function() onAlreadyHaveAccountClick;
  final bool isLoading;
  const GenderFieldsRegistrationScreen(
      {super.key,
      required this.onNextPage,
      required this.onAlreadyHaveAccountClick,
      required this.isLoading});

  @override
  State<GenderFieldsRegistrationScreen> createState() =>
      _GenderFieldsRegistrationScreenState();
}

class _GenderFieldsRegistrationScreenState
    extends State<GenderFieldsRegistrationScreen> {
  late GlobalKey<FormState> formKey;
  final RegistrationService _registrationService =
      GetIt.instance<RegistrationService>();
  String? _selectedGender;
  bool _showError = false;

  void _handleNext() {
    if (_selectedGender == null) {
      setState(() {
        _showError = true;
        print("From GenderFieldRegistration - Validation failed");
      });
    } else {
      setState(() {
        _showError = false;
      });
      _registrationService.updateGender(_selectedGender!);
      widget.onNextPage();
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
            "What's your gender?",
            style: EcoPointsTextStyles.blackTextStyle(
                size: width * 0.045, weight: FontWeight.w600),
          ),
          Gap(height * 0.01),
          Text(
            "You can change your gender on your profile later.",
            style: EcoPointsTextStyles.blackTextStyle(
                size: width * 0.035, weight: FontWeight.normal),
          ),
          Gap(width * 0.03),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: EcoPointsColors.lightGreenShade,
            ),
            child: Column(
              children: [
                ...['Male', 'Female', 'Prefer not to say'].map(
                  (gender) => RadioListTile<String>(
                    title: Text(
                      gender,
                      style: EcoPointsTextStyles.blackTextStyle(
                        size: width * 0.035,
                        weight: FontWeight.w500,
                      ),
                    ),
                    value: gender,
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          if (_showError)
            Column(
              children: [
                Gap(width * 0.04),
                Row(
                  children: [
                    const Icon(
                      CupertinoIcons.exclamationmark_circle,
                      color: EcoPointsColors.red,
                    ),
                    Gap(width * 0.02),
                    Text(
                      "Gender must be either of the choices.",
                      style: EcoPointsTextStyles.redTextStyle(
                          size: width * 0.032, weight: FontWeight.normal),
                    ),
                  ],
                ),
              ],
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
