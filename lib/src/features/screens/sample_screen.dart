import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CounterScreen extends StatefulWidget {
  static const String route = 'counter';
  static const String path = '/counter';
  static const String name = 'Counter Screen';

  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int number = 0;

  addNumber() {
    setState(() {
      number++;
    });
  }

  minusNumber() {
    setState(() {
      number--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(CupertinoIcons.back),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Number: $number'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(CupertinoIcons.add),
                onPressed: () {
                  addNumber();
                },
              ),
              IconButton(
                icon: const Icon(CupertinoIcons.minus),
                onPressed: () {
                  minusNumber();
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
