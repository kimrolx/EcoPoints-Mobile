import 'package:flutter/material.dart';

class RewardsCatalogScreen extends StatelessWidget {
  static const String route = "/rewards";
  static const String path = "/rewards";
  static const String name = "RewardsCatalogScreen";
  const RewardsCatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Rewards Catalog'),
      ),
    );
  }
}
