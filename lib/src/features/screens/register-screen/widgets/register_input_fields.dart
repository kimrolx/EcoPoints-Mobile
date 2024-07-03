import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:gap/gap.dart';

import '../../../../components/fields/custom_text_form_field.dart';

class RegisterInputFieldsRegistrationScreen extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController email, password, confirmPassword;
  final FocusNode emailFn, passwordFn, confirmPasswordFn;
  final Function onSubmit;
  const RegisterInputFieldsRegistrationScreen({
    super.key,
    required this.formKey,
    required this.email,
    required this.password,
    required this.emailFn,
    required this.passwordFn,
    required this.onSubmit,
    required this.confirmPassword,
    required this.confirmPasswordFn,
  });

  @override
  State<RegisterInputFieldsRegistrationScreen> createState() =>
      _RegisterInputFieldsRegistrationScreenState();
}

class _RegisterInputFieldsRegistrationScreenState
    extends State<RegisterInputFieldsRegistrationScreen> {
  bool obfuscate = true;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Form(
      key: widget.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: CustomTextFormField(
              hintText: "Email",
              labelText: "Email",
              obscureText: false,
              keyboardType: TextInputType.text,
              errorMaxLines: 3,
              controller: widget.email,
              focusNode: widget.emailFn,
              onEditingComplete: () {
                widget.passwordFn.requestFocus();
              },
              validator: MultiValidator([
                RequiredValidator(errorText: "Email is required"),
                MinLengthValidator(
                  4,
                  errorText: "Email must be at least 6 characters long",
                ),
              ]).call,
            ),
          ),
          Gap(height * 0.015),
          Flexible(
            child: CustomTextFormField(
              hintText: "Password",
              labelText: "Password",
              obscureText: obfuscate,
              keyboardType: TextInputType.visiblePassword,
              errorMaxLines: 3,
              controller: widget.password,
              focusNode: widget.passwordFn,
              onEditingComplete: () {
                widget.confirmPasswordFn.requestFocus();
              },
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obfuscate = !obfuscate;
                  });
                },
                icon: Icon(obfuscate
                    ? Icons.remove_red_eye_rounded
                    : CupertinoIcons.eye_slash),
              ),
              validator: MultiValidator([
                RequiredValidator(
                  errorText: "Password is required",
                ),
                MinLengthValidator(
                  8,
                  errorText: "Password must to be at least 12 characters long",
                ),
                MaxLengthValidator(
                  128,
                  errorText: "Password cannot exceed 72 characters",
                ),
                PatternValidator(
                  r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+?\-=[\]{};':,.<>]).*$",
                  errorText:
                      'Password must contain at least one symbol, one uppercase letter, one lowercase letter, and one number',
                ),
              ]).call,
            ),
          ),
          Gap(height * 0.015),
          Flexible(
            child: CustomTextFormField(
              hintText: "Confirm Password",
              labelText: "Confirm Password",
              obscureText: obfuscate,
              keyboardType: TextInputType.visiblePassword,
              errorMaxLines: 3,
              controller: widget.confirmPassword,
              focusNode: widget.confirmPasswordFn,
              onEditingComplete: () {
                widget.confirmPasswordFn.unfocus();
                widget.onSubmit();
              },
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obfuscate = !obfuscate;
                  });
                },
                icon: Icon(obfuscate
                    ? Icons.remove_red_eye_rounded
                    : CupertinoIcons.eye_slash),
              ),
              validator: (v) {
                String? doesPasswordsMatch =
                    widget.password.text == widget.confirmPassword.text
                        ? null
                        : "Passwords doesn't match";
                if (doesPasswordsMatch != null) {
                  return doesPasswordsMatch;
                } else {
                  MultiValidator([
                    RequiredValidator(
                      errorText: "Password is required",
                    ),
                    MinLengthValidator(
                      8,
                      errorText:
                          "Password must to be at least 12 characters long",
                    ),
                    MaxLengthValidator(
                      128,
                      errorText: "Password cannot exceed 72 characters",
                    ),
                    PatternValidator(
                      r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+?\-=[\]{};':,.<>]).*$",
                      errorText:
                          'Password must contain at least one symbol, one uppercase letter, one lowercase letter, and one number',
                    ),
                  ]).call(v);
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
