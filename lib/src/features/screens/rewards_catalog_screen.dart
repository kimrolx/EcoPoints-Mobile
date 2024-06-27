import 'package:flutter/material.dart';

class RewardsCatalogScreen extends StatelessWidget {
  static const String route = "/rewardscatalog";
  static const String path = "/rewardscatalog";
  static const String name = "Rewards Catalog Screen";
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
