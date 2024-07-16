import 'package:flutter/material.dart';

class PlaceholderScreen extends StatelessWidget {
  static const String route = "/placeholder";
  static const String path = "/placeholder";
  static const String name = "PlaceholderScreen";
  const PlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
