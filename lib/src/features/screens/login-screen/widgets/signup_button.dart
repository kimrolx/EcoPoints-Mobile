import 'package:flutter/material.dart';

import '../../../../components/constants/text_style/ecopoints_themes.dart';
import '../../../../routes/router.dart';
import '../../register-screen/registration_screen.dart';

class SignUpLoginScreen extends StatelessWidget {
  const SignUpLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Expanded(
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
                  onPressed: () {
                    //TODO
                    GlobalRouter.I.router.push(RegistrationScreen.path);
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(0, 0),
                  ),
                  child: Text(
                    "Join us!",
                    style: EcoPointsTextStyles.darkGreenTextStyle(
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
    );
  }
}
