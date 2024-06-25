import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/buttons/custom_elevated_button.dart';
import '../../../components/constants/colors/ecopoints_colors.dart';
import '../../../components/constants/text_style/ecopoints_themes.dart';
import '../../../components/fields/custom_text_form_field.dart';

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

  bool obfuscate = true;

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
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Image.asset(
                    "assets/logos/logo.png",
                    width: 100,
                    height: 100,
                  ),
                  Gap(height * 0.1),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) {
                          return const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              EcoPointsColors.darkGreen,
                              EcoPointsColors.lightGreen,
                            ],
                          ).createShader(bounds);
                        },
                        child: Text(
                          "Eco",
                          style: EcoPointsTextStyles.whiteTextStyle(
                            size: width * 0.1,
                            weight: FontWeight.normal,
                          ),
                        ),
                      ),
                      ShaderMask(
                        shaderCallback: (bounds) {
                          return const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              EcoPointsColors.darkBlue,
                              EcoPointsColors.lightBlue,
                            ],
                          ).createShader(bounds);
                        },
                        child: Text(
                          "Points",
                          style: EcoPointsTextStyles.whiteTextStyle(
                            size: width * 0.1,
                            weight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Your partner in a sustainable future.",
                    style: EcoPointsTextStyles.blackTextStyle(
                      size: 16.0,
                      weight: FontWeight.w500,
                    ),
                  ),
                  Gap(height * 0.075),
                  Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: CustomTextFormField(
                              labelText: "Email",
                              focusNode: usernameFn,
                              controller: username,
                              obscureText: false,
                              keyboardType: TextInputType.text,
                              errorMaxLines: 3,
                              onEditingComplete: () {
                                passwordFn.requestFocus();
                              },
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: "Username is required"),
                                MinLengthValidator(
                                  4,
                                  errorText:
                                      "Username must be at least 6 characters long",
                                ),
                                PatternValidator(
                                  r'^[a-zA-Z0-9 ]+$',
                                  errorText:
                                      'Username cannot contain any special characters',
                                ),
                              ]).call,
                            ),
                          ),
                          Gap(height * 0.015),
                          Flexible(
                            child: CustomTextFormField(
                              labelText: "Password",
                              focusNode: passwordFn,
                              controller: password,
                              obscureText: obfuscate,
                              keyboardType: TextInputType.visiblePassword,
                              errorMaxLines: 3,
                              onEditingComplete: () {
                                passwordFn.unfocus();
                                onSubmit();
                              },
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      obfuscate = !obfuscate;
                                    });
                                  },
                                  icon: Icon(obfuscate
                                      ? Icons.remove_red_eye_rounded
                                      : CupertinoIcons.eye_slash)),
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: "Password is required"),
                                MinLengthValidator(
                                  8,
                                  errorText:
                                      "Password must to be at least 12 characters long",
                                ),
                                PatternValidator(
                                  r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+?\-=[\]{};':,.<>]).*$",
                                  errorText:
                                      'Password must contain at least one symbol, one uppercase letter, one lowercase letter, and one number',
                                ),
                              ]).call,
                            ),
                          ),
                        ],
                      )),
                  Gap(height * 0.02),
                  CustomElevatedButton(
                    onPressed: () {
                      //TODO: Add `Log in` event handler
                      onSubmit();
                    },
                    backgroundColor: EcoPointsColors.darkGreen,
                    width: width,
                    padding: const EdgeInsets.all(10),
                    borderRadius: 10.0,
                    child: Text(
                      "Log in",
                      style: GoogleFonts.poppins(
                        fontSize: height * 0.02,
                        fontWeight: FontWeight.w600,
                        color: EcoPointsColors.white,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed:
                        () {}, //TODO: Add `Forgot Password` event handler
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 0),
                      textStyle: TextStyle(
                        fontSize: width * 0.035,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    child: const Text(
                      "Forgot password?",
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: RichText(
                        text: TextSpan(
                          text: "Don't have an account? ",
                          style: EcoPointsTextStyles.grayTextStyle(
                            size: width * 0.035,
                            weight: FontWeight.w500,
                          ),
                          children: [
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: TextButton(
                                onPressed:
                                    () {}, //TODO: Add `Register Account`event handler
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: const Size(0, 0),
                                ),
                                child: Text(
                                  "Join us!",
                                  style: EcoPointsTextStyles.greenTextStyle(
                                    size: width * 0.035,
                                    weight: FontWeight.w500,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  onSubmit() async {
    // if (formKey.currentState?.validate() ?? false) {
    //   WaitingDialog.show(context,
    //       future: AuthController.I
    //           .login(username.text.trim(), password.text.trim()));
    // }
  }
}
