import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:gap/gap.dart';

import '../../../../components/fields/custom_text_form_field.dart';

class InputFieldsLoginScreen extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController email, password;
  final FocusNode emailFn, passwordFn;
  final Function onSubmit;
  const InputFieldsLoginScreen({
    super.key,
    required this.formKey,
    required this.email,
    required this.password,
    required this.emailFn,
    required this.passwordFn,
    required this.onSubmit,
  });

  @override
  State<InputFieldsLoginScreen> createState() => _InputFieldsLoginScreenState();
}

class _InputFieldsLoginScreenState extends State<InputFieldsLoginScreen> {
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
              labelText: "Email",
              hintText: "Email",
              focusNode: widget.emailFn,
              controller: widget.email,
              obscureText: false,
              keyboardType: TextInputType.text,
              errorMaxLines: 3,
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
              labelText: "Password",
              hintText: "Password",
              focusNode: widget.passwordFn,
              controller: widget.password,
              obscureText: obfuscate,
              keyboardType: TextInputType.visiblePassword,
              errorMaxLines: 3,
              onEditingComplete: () {
                widget.passwordFn.unfocus();
                widget.onSubmit();
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
                RequiredValidator(errorText: "Password is required"),
                MinLengthValidator(
                  8,
                  errorText: "Password must to be at least 8 characters long",
                ),
              ]).call,
            ),
          ),
        ],
      ),
    );
  }
}
