import 'package:flutter/material.dart';

import '../../components/dialogs/loading_dialog.dart';
import '../../controllers/auth_controller.dart';
import '../../routes/router.dart';
import 'home/home_screen.dart';

class AccountScreen extends StatelessWidget {
  static const String route = '/';
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
              onPressed: () => _handleLogout(context),
              child: const Text("Log out"),
            ),
          ],
        ),
      ),
    );
  }

  void _handleLogout(BuildContext context) {
    WaitingDialog.show(
      context,
      future: AuthController.I.logout(),
      prompt: "Logging out...",
    ).then((_) {
      GlobalRouter.I.router.push(HomeScreen.path);
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logout failed: $error')),
      );
    });
  }
}
