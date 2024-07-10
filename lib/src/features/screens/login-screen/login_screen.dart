import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../components/constants/text_style/ecopoints_themes.dart';
import '../../../components/dialogs/loading_dialog.dart';
import '../../../controllers/auth_controller.dart';
import 'widgets/continue_with_google_button.dart';
import 'widgets/forgot_password.dart';
import 'widgets/header.dart';
import 'widgets/login_input_fields.dart';
import 'widgets/login_button.dart';
import 'widgets/signup_button.dart';

class LoginScreen extends StatefulWidget {
  static const String route = "/auth";
  static const String name = "Login Screen";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late GlobalKey<FormState> formKey;
  late TextEditingController username, password;
  late FocusNode usernameFn, passwordFn;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    username = TextEditingController();
    password = TextEditingController();
    usernameFn = FocusNode();
    passwordFn = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    username.dispose();
    password.dispose();
    usernameFn.dispose();
    passwordFn.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          width: width,
          height: height,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.05,
                vertical: height * 0.02,
              ),
              child: Column(
                children: [
                  Image.asset(
                    "assets/logos/logo.png",
                    width: 100,
                    height: 100,
                  ),
                  Gap(height * 0.02),
                  const HeaderLoginScreen(),
                  Text(
                    "Your partner in a sustainable future.",
                    style: EcoPointsTextStyles.blackTextStyle(
                      size: 16.0,
                      weight: FontWeight.w500,
                    ),
                  ),
                  Gap(height * 0.075),
                  InputFieldsLoginScreen(
                    formKey: formKey,
                    email: username,
                    password: password,
                    emailFn: usernameFn,
                    passwordFn: passwordFn,
                    onSubmit: onLoginButtonClick,
                  ),
                  Gap(height * 0.015),
                  LoginButtonLoginScreen(
                    onSubmit: onLoginButtonClick,
                  ),
                  const ForgotPasswordLoginScreen(), //TODO: Add `Forgot Password` event handler
                  const Divider(),
                  Gap(height * 0.02),
                  ContinueWithGoogleButtonLoginScreen(
                    onPressed: onGoogleLoginClick,
                  ),
                  const SignUpLoginScreen(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  onLoginButtonClick() async {
    if (formKey.currentState?.validate() ?? false) {
      await WaitingDialog.show(
        context,
        future: Future.delayed(const Duration(seconds: 1)).then(
          (_) async {
            AuthController.I.login(username.text.trim(), password.text.trim());
          },
        ),
        prompt: "Give us a sec...",
      );
    }
  }

  onGoogleLoginClick() async {
    await WaitingDialog.show(context,
        future: AuthController.I.loginWithGoogle());
  }
}
