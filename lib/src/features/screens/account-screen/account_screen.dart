import 'package:flutter/material.dart';

import '../../../components/dialogs/loading_dialog.dart';
import '../../../controllers/auth_controller.dart';

class AccountScreen extends StatelessWidget {
  static const String route = "/account";
  static const String path = "/account";
  static const String name = "Account Name";
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Account Screen"),
            ElevatedButton(
              onPressed: () {
                onLogoutClick(context);
              },
              child: const Text("Log out"),
            ),
          ],
        ),
      ),
    );
  }

  void onLogoutClick(BuildContext context) {
    WaitingDialog.show(
      context,
      future: Future.delayed(const Duration(seconds: 1)).then((_) async {
        await AuthController.I.logout();
      }),
    );
  }
}
