import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  StreamSubscription<DocumentSnapshot>? _firestoreSubscription;
  Timer? _verificationCheckTimer;
  late StreamSubscription<int> _cooldownSubscription;
  late String _userId;
  int _secondsRemaining = 0;

  @override
  void initState() {
    super.initState();
    _userId = _firebaseServices.getCurrentUser()?.uid ?? '';

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        _userId = user.uid;
        _setupFirestoreListener();
      } else {
        _firestoreSubscription?.cancel();
        _firestoreSubscription = null;
        _secondsRemaining = 0;
        if (mounted) setState(() {});
        print("User is logged out, listener canceled.");
      }
    });

    _cooldownSubscription =
        _cooldownTimerUtil.getCooldownStream(_userId).listen((seconds) {
      if (mounted) {
        setState(() {
          _secondsRemaining = seconds;
        });
      }
    });

    _startVerificationCheck();
  }

  @override
  void dispose() {
    _firestoreSubscription?.cancel();
    _verificationCheckTimer?.cancel();
    _cooldownSubscription.cancel();
    _cooldownTimerUtil.dispose(_userId);
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
                      backgroundColor: _secondsRemaining > 0
                          ? EcoPointsColors.lightGray
                          : EcoPointsColors.lightGreen,
                      width: width * 0.5,
                      onPressed: _secondsRemaining > 0
                          ? () {}
                          : _resendEmailVerification,
                      child: Text(
                        _secondsRemaining > 0
                            ? "Resend in $_secondsRemaining seconds"
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

  void _setupFirestoreListener() {
    // Cancel any existing listener to avoid duplicates
    _firestoreSubscription?.cancel();

    // Set up a new Firestore listener for the current user
    _firestoreSubscription = FirebaseFirestore.instance
        .collection('users')
        .doc(_userId)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists &&
          snapshot.data()!['lastEmailVerificationSent'] != null) {
        DateTime lastSentTime =
            DateTime.parse(snapshot.data()!['lastEmailVerificationSent']);
        int elapsedSeconds = DateTime.now().difference(lastSentTime).inSeconds;

        if (elapsedSeconds < _cooldownTimerUtil.cooldownDuration) {
          int remainingSeconds =
              _cooldownTimerUtil.cooldownDuration - elapsedSeconds;

          if (!_cooldownTimerUtil.isCooldownActive(_userId)) {
            print(
                "Starting cooldown with remaining seconds: $remainingSeconds");
            _cooldownTimerUtil.startCooldownWithSeconds(
                _userId, remainingSeconds);
          }
          if (mounted) {
            setState(() {
              _secondsRemaining = remainingSeconds;
            });
          }
        } else {
          print("Cooldown expired, no countdown needed.");
          if (mounted) {
            setState(() {
              _secondsRemaining = 0;
            });
          }
        }
      } else {
        print(
            "No previous cooldown found or lastEmailVerificationSent is null.");
        if (mounted) {
          setState(() {
            _secondsRemaining = 0;
          });
        }
      }
    });
  }

  //* Method to handle resending the email verification
  void _resendEmailVerification() async {
    bool emailSent = await _firebaseServices.sendEmailVerification();
    if (emailSent) {
      print("Email sent, starting cooldown..."); // Debug print
      _cooldownTimerUtil.startCooldownWithSeconds(
          _userId, _cooldownTimerUtil.cooldownDuration);
    } else {
      print("Failed to send email."); // Debug print
    }
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
