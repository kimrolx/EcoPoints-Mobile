import 'package:flutter/material.dart';

import '../../../routes/router.dart';
import '../sample_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String route = '/home';
  static const String path = "/home";
  static const String name = "Home Screen";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Home Screen"),
            ElevatedButton(
              onPressed: () {
                GlobalRouter.I.router.push(CounterScreen.path);
              },
              child: const Text("Go to Counter Screen"),
            ),
          ],
        ),
      ),
    );
  }
}
