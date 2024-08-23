import 'dart:async';

import 'package:ecopoints/src/shared/utils/cooldown_timer_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';

import '../../../components/buttons/custom_elevated_button.dart';
import '../../../components/constants/colors/ecopoints_colors.dart';
import '../../../components/constants/text_style/ecopoints_themes.dart';
import '../../../components/dialogs/loading_dialog.dart';
import '../../../controllers/auth_controller.dart';
import '../../../routes/router.dart';
import '../../../shared/services/firebase_services.dart';
import '../home-screen/home_screen.dart';

class LoginEmailVerificationScreen extends StatefulWidget {
  static const String route = "/verify-email";
  static const String path = "/verify-email";
  static const String name = "LoginEmailVerificationScreen";
  const LoginEmailVerificationScreen({super.key});

  @override
  State<LoginEmailVerificationScreen> createState() =>
      _LoginEmailVerificationScreenState();
}

class _LoginEmailVerificationScreenState
    extends State<LoginEmailVerificationScreen> {
  final FirebaseServices _firebaseServices = GetIt.instance<FirebaseServices>();
  final CooldownTimerUtil _cooldownTimerUtil =
      GetIt.instance<CooldownTimerUtil>();
  Timer? _verificationCheckTimer;
  late StreamSubscription<int> _cooldownSubscription;

  @override
  void initState() {
    super.initState();
    _startVerificationCheck();

    _cooldownSubscription = _cooldownTimerUtil.secondsStream.listen((seconds) {
      setState(() {});
    });

    if (!_cooldownTimerUtil.isTimerActive()) {
      _cooldownTimerUtil.startCooldown();
    }
  }

  @override
  void dispose() {
    _verificationCheckTimer?.cancel();
    _cooldownSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: EcoPointsColors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () => onClose(),
                icon: const Icon(CupertinoIcons.clear)),
            Padding(
              padding: EdgeInsets.only(
                left: width * 0.04,
                right: width * 0.04,
                bottom: height * 0.03,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Verification Link Sent!",
                    style: EcoPointsTextStyles.blackTextStyle(
                        size: width * 0.045, weight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: height * 0.25,
                    width: width,
                    child: Lottie.asset(
                      "assets/animations/email-checkmark-animation.json",
                      fit: BoxFit.contain,
                    ),
                  ),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          "${_firebaseServices.getCurrentUserEmail()}",
                          style: EcoPointsTextStyles.blackTextStyle(
                              size: width * 0.04, weight: FontWeight.w500),
                        ),
                        Text(
                          "Please check your email for the verification link.",
                          style: EcoPointsTextStyles.blackTextStyle(
                              size: width * 0.035, weight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  Gap(height * 0.02),
                  Center(
                    child: CustomElevatedButton(
                      borderRadius: 50,
                      backgroundColor: _cooldownTimerUtil.secondsRemaining > 0
                          ? EcoPointsColors.lightGray
                          : EcoPointsColors.lightGreen,
                      width: width * 0.5,
                      onPressed: _cooldownTimerUtil.secondsRemaining > 0
                          ? () {}
                          : _resendEmailVerification,
                      child: Text(
                        _cooldownTimerUtil.secondsRemaining > 0
                            ? "Resend in ${_cooldownTimerUtil.secondsRemaining} seconds"
                            : "Resend Email",
                        style: EcoPointsTextStyles.blackTextStyle(
                          size: width * 0.035,
                          weight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  onClose() {
    AuthController.I.logout();
  }

  //* Method to handle resending the email verification
  void _resendEmailVerification() async {
    await _firebaseServices.sendEmailVerification();
    _cooldownTimerUtil.startCooldown();
  }

  //* Method to start checking if the user's email is verified
  void _startVerificationCheck() {
    _verificationCheckTimer = Timer.periodic(
      const Duration(seconds: 2),
      (timer) async {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await user.reload();
          if (user.emailVerified) {
            timer.cancel();
            _redirectToHome();
          }
        }
      },
    );
  }

  //* Method to redirect to the home screen after verification
  void _redirectToHome() {
    WaitingDialog.show(
      context,
      future: Future.delayed(const Duration(seconds: 2)).then(
        (_) async {
          GlobalRouter.I.router.go(HomeScreen.route);
        },
      ),
    );
  }
}
