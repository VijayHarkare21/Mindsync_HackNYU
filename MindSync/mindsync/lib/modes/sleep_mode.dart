import 'package:flutter/material.dart';

class SleepMode extends StatelessWidget {
  const SleepMode({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Sleep Mode Activated",
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
