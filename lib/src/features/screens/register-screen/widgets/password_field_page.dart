import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';

import '../../../../components/buttons/custom_elevated_button.dart';
import '../../../../components/constants/colors/ecopoints_colors.dart';
import '../../../../components/constants/text_style/ecopoints_themes.dart';
import '../../../../components/dialogs/loading_dialog.dart';
import '../../../../components/fields/custom_text_form_field.dart';
import '../../../../components/misc/custom_circular_progress_indicator.dart';
import '../../../../controllers/auth_controller.dart';
import '../../../../models/user_profile_model.dart';
import '../../../../shared/services/registration_form_service.dart';

class PasswordFieldRegistrationScreen extends StatefulWidget {
  final TextEditingController passwordController;
  final FocusNode passwordFn;
  final Function() onNextPage;
  final Function() onAlreadyHaveAccountClick;
  final bool isLoading;
  const PasswordFieldRegistrationScreen(
      {super.key,
      required this.onNextPage,
      required this.onAlreadyHaveAccountClick,
      required this.passwordController,
      required this.passwordFn,
      required this.isLoading});

  @override
  State<PasswordFieldRegistrationScreen> createState() =>
      _PasswordFieldRegistrationScreenState();
}

class _PasswordFieldRegistrationScreenState
    extends State<PasswordFieldRegistrationScreen> {
  final RegistrationService _registrationService =
      GetIt.instance<RegistrationService>();
  late GlobalKey<FormState> formKey;
  bool obfuscate = true;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    widget.passwordFn.requestFocus();
  }

  void _handleNext() async {
    if (formKey.currentState?.validate() ?? false) {
      FocusManager.instance.primaryFocus?.unfocus();
      final UserProfileModel userProfile = _registrationService.userProfile;

      try {
        bool registrationSuccess = await WaitingDialog.show(
              context,
              future: AuthController.I.register(
                  userProfile.email ?? "No email provided",
                  widget.passwordController.text.trim()),
            ) ??
            false;

        Future.delayed(const Duration(milliseconds: 1500)).then((_) async {
          if (registrationSuccess) {
            userProfile.reset();
            print("Registration successful and user profile reset.");
          } else {
            print("Registration failed. User profile not reset.");
          }
        });
      } catch (e) {
        print("An error occurred during registration: $e");
      }
    } else {
      print("Validation failed.");
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
            "Create a password",
            style: EcoPointsTextStyles.blackTextStyle(
                size: width * 0.045, weight: FontWeight.w600),
          ),
          Gap(height * 0.01),
          Text(
            "Make sure no one is looking.",
            style: EcoPointsTextStyles.blackTextStyle(
                size: width * 0.035, weight: FontWeight.normal),
          ),
          Gap(width * 0.04),
          Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: CustomTextFormField(
                    hintText: "Password",
                    labelText: "Password",
                    obscureText: obfuscate,
                    keyboardType: TextInputType.visiblePassword,
                    errorMaxLines: 3,
                    controller: widget.passwordController,
                    focusNode: widget.passwordFn,
                    onEditingComplete: () {
                      widget.passwordFn.unfocus();
                    },
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obfuscate = !obfuscate;
                          });
                        },
                        icon: Icon(obfuscate
                            ? CupertinoIcons.eye_slash
                            : Icons.remove_red_eye_rounded)),
                    validator: MultiValidator([
                      RequiredValidator(
                        errorText: "Password is required",
                      ),
                      MinLengthValidator(
                        8,
                        errorText:
                            "Password must to be at least 8 characters long",
                      ),
                      PatternValidator(
                        r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+?\-=[\]{};':,.<>]).*$",
                        errorText:
                            "Password must contain at least one symbol, one uppercase letter, one lowercase letter, and one number",
                      ),
                    ]).call,
                  ),
                ),
              ],
            ),
          ),
          Gap(width * 0.04),
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
                    "Create Account",
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
