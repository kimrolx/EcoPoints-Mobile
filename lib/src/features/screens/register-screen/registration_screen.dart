import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../components/constants/colors/ecopoints_colors.dart';
import '../../../components/constants/text_style/ecopoints_themes.dart';
import '../../../components/dialogs/loading_dialog.dart';
import '../../../controllers/auth_controller.dart';
import 'widgets/header.dart';
import 'widgets/register_button.dart';
import 'widgets/register_input_fields.dart';
import 'widgets/signup_with_google.dart';

class RegistrationScreen extends StatefulWidget {
  static const String route = '/register';
  static const String path = "/register";
  static const String name = "Register Screen";
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late GlobalKey<FormState> formKey;
  late TextEditingController email, password, confirmPassword;
  late FocusNode emailFn, passwordFn, confirmpasswordFn;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    email = TextEditingController();
    emailFn = FocusNode();
    password = TextEditingController();
    passwordFn = FocusNode();
    confirmPassword = TextEditingController();
    confirmpasswordFn = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    emailFn.dispose();
    password.dispose();
    passwordFn.dispose();
    confirmPassword.dispose();
    confirmpasswordFn.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: EcoPointsColors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          width: width,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: Navigator.of(context).pop,
                  icon: const Icon(CupertinoIcons.back),
                ),
                Gap(height * 0.05),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.05,
                    vertical: height * 0.02,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const HeaderRegistrationScreen(),
                      Text(
                        "Let's Turn Trash into Treasure",
                        style: EcoPointsTextStyles.blackTextStyle(
                          size: width * 0.04,
                          weight: FontWeight.w600,
                        ),
                      ),
                      Gap(height * 0.075),
                      RegisterInputFieldsRegistrationScreen(
                        formKey: formKey,
                        email: email,
                        emailFn: emailFn,
                        password: password,
                        passwordFn: passwordFn,
                        confirmPassword: confirmPassword,
                        confirmPasswordFn: confirmpasswordFn,
                        onSubmit: onRegisterButtonClick,
                      ),
                      Gap(height * 0.015),
                      RegisterButtonRegistrationScreen(
                        onSubmit: onRegisterButtonClick,
                      ),
                      Gap(height * 0.02),
                      const Divider(),
                      Gap(height * 0.02),
                      SignUpWithGoogleRegistrationScreen(
                        onPressed: onGoogleLoginClick,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onRegisterButtonClick() {
    if (formKey.currentState?.validate() ?? false) {
      WaitingDialog.show(
        context,
        future: Future.delayed(const Duration(seconds: 2)).then(
          (_) async {
            await AuthController.I
                .register(email.text.trim(), password.text.trim());
          },
        ),
      );
    }
  }

  onGoogleLoginClick() async {
    await WaitingDialog.show(context,
        future: AuthController.I.loginWithGoogle());
  }
}
