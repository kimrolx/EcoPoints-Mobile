import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../components/buttons/custom_elevated_button.dart';
import '../../../components/constants/colors/ecopoints_colors.dart';
import '../../../components/constants/text_style/ecopoints_themes.dart';
import '../../../components/dialogs/error_dialog.dart';
import '../../../components/dialogs/loading_dialog.dart';
import '../../../routes/router.dart';
import '../../../shared/services/firebase_services.dart';
import '../../../shared/utils/ui_helpers.dart';
import '../login-screen/login_screen.dart';
import '../../../components/dialogs/email_sent_dialog.dart';
import 'widgets/forgot_password_form.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String route = '/forgotpassword';
  static const String path = "/forgotpassword";
  static const String name = "Forgotten Password Screen";
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late TextEditingController emailController;
  late FocusNode emailFn;
  late GlobalKey<FormState> formKey;
  final FirebaseServices _userFirestoreService =
      GetIt.instance<FirebaseServices>();

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

  void _showPasswordResetEmailSent(BuildContext context, String description) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => PasswordResetDialogForgotPasswordScreen(
        onDialogDismiss: onDialogDismiss,
        description: description,
      ),
    );
  }

  void _showErrorDialog(
      BuildContext context, String title, String description) {
    showDialog(
      context: context,
      builder: (context) => ErrorDialog(title: title, description: description),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return dismissKeyboardOnTap(
      context: context,
      child: Scaffold(
        backgroundColor: EcoPointsColors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: IconButton(
                icon: const Icon(CupertinoIcons.back),
                onPressed: () {
                  context.pop();
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: width * 0.045,
                right: width * 0.045,
                bottom: height * 0.03,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Forgot your password?",
                    style: EcoPointsTextStyles.blackTextStyle(
                        size: width * 0.045, weight: FontWeight.w600),
                  ),
                  Gap(height * 0.01),
                  Text(
                    "Enter the email you used during registration and we'll send you a link to reset your password.",
                    style: EcoPointsTextStyles.blackTextStyle(
                        size: width * 0.035, weight: FontWeight.normal),
                  ),
                  Gap(width * 0.03),
                  FormForgotPasswordScreen(
                    onContinue: onContinueClick,
                    formKey: formKey,
                    emailController: emailController,
                    emailFn: emailFn,
                  ),
                  Gap(width * 0.02),
                  CustomElevatedButton(
                    onPressed: onContinueClick,
                    backgroundColor: EcoPointsColors.darkGreen,
                    width: width,
                    padding: const EdgeInsets.all(4),
                    borderRadius: 50.0,
                    child: Text(
                      "Continue",
                      style: EcoPointsTextStyles.whiteTextStyle(
                        size: width * 0.04,
                        weight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  onContinueClick() async {
    if (formKey.currentState?.validate() ?? false) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const WaitingDialog();
        },
      );

      try {
        await _userFirestoreService
            .sendPasswordResetEmail(emailController.text.trim());

        if (mounted) {
          Navigator.of(context).pop();

          _showPasswordResetEmailSent(
              context, "A password reset email has been sent to your email.");
        }
      } catch (e) {
        if (mounted) {
          Navigator.of(context).pop();
          _showErrorDialog(context, "Oh no!",
              "Something went wrong. Please try again later or contact support.");
        }
      }
    }
  }

  onDialogDismiss() {
    GlobalRouter.I.router.go(LoginScreen.route);
  }
}
