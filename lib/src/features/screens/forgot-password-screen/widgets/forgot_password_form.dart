import 'package:flutter/cupertino.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../../../components/fields/custom_text_form_field.dart';

class FormForgotPasswordScreen extends StatelessWidget {
  final Function() onContinue;
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final FocusNode emailFn;
  const FormForgotPasswordScreen(
      {super.key,
      required this.formKey,
      required this.emailController,
      required this.emailFn,
      required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: CustomTextFormField(
              hintText: "Email",
              labelText: "Email",
              obscureText: false,
              keyboardType: TextInputType.emailAddress,
              errorMaxLines: 3,
              controller: emailController,
              focusNode: emailFn,
              onEditingComplete: () {
                emailFn.unfocus();
                onContinue();
              },
              validator: MultiValidator([
                RequiredValidator(errorText: "Email is required."),
                EmailValidator(errorText: "Enter a valid email address"),
              ]).call,
            ),
          ),
        ],
      ),
    );
  }
}
