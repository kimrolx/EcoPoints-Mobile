import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../components/constants/colors/ecopoints_colors.dart';
import '../../../routes/router.dart';
import '../../../shared/services/registration_form_service.dart';
import '../../../shared/utils/ui_helpers.dart';
import '../login-screen/login_screen.dart';
import 'widgets/email_field_page.dart';
import 'widgets/gender_fields_page.dart';
import 'widgets/name_fields_page.dart';
import 'widgets/get_started_page.dart';
import 'widgets/password_field_page.dart';

class RegistrationScreen extends StatefulWidget {
  static const String route = '/register';
  static const String path = "/register";
  static const String name = "Register Screen";
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  int _currentPageIndex = 0;
  late PageController _pageController;
  late TextEditingController password;
  late FocusNode passwordFn;
  final RegistrationService _registrationService =
      GetIt.instance<RegistrationService>();

  @override
  void initState() {
    super.initState();
    password = TextEditingController();
    passwordFn = FocusNode();
    _pageController = PageController();
    _pageController.addListener(_updatePageIndex);
  }

  @override
  void dispose() {
    password.dispose();
    passwordFn.dispose();
    _pageController.dispose();
    _pageController.removeListener(_updatePageIndex);
    super.dispose();
  }

  void _updatePageIndex() {
    int currentPage = _pageController.page!.round();
    print("Current Page Index Updated: $currentPage");
    if (_currentPageIndex != currentPage) {
      setState(() {
        _currentPageIndex = currentPage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return dismissKeyboardOnTap(
      context: context,
      child: Scaffold(
        backgroundColor: EcoPointsColors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SafeArea(
              child: IconButton(
                onPressed: () {
                  if (_currentPageIndex == 0 || _currentPageIndex == 5) {
                    onAlreadyHaveAccountClick();
                  } else {
                    onPreviousPage();
                  }
                },
                icon: const Icon(CupertinoIcons.back),
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  GetStartedRegistrationScreen(onSubmit: onGetStartedClick),
                  NameFieldsRegistrationScreen(
                    onNextPageClick: onNextPage,
                    onAlreadyHaveAccountClick: onAlreadyHaveAccountClick,
                  ),
                  GenderFieldsRegistrationScreen(
                    onNextPage: onNextPage,
                    onAlreadyHaveAccountClick: onAlreadyHaveAccountClick,
                  ),
                  EmailFieldRegistrationScreen(
                    onNextPage: onNextPage,
                    onAlreadyHaveAccountClick: onAlreadyHaveAccountClick,
                  ),
                  PasswordFieldRegistrationScreen(
                    onNextPage: onNextPage,
                    onAlreadyHaveAccountClick: onAlreadyHaveAccountClick,
                    passwordController: password,
                    passwordFn: passwordFn,
                  ),
                  // ConfirmationCodeRegistrationScreen(
                  //   onNextPage: onNextPage,
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  onGetStartedClick() {
    onNextPage();
  }

  onNextPage() {
    if (_pageController.hasClients) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
    }
  }

  onPreviousPage() {
    if (_pageController.hasClients) {
      FocusManager.instance.primaryFocus?.unfocus();
      _pageController.previousPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
    }
  }

  onAlreadyHaveAccountClick() {
    FocusManager.instance.primaryFocus?.unfocus();
    _registrationService.userProfile.reset();
    GlobalRouter.I.router.go(LoginScreen.route);
  }
}
