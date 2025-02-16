import 'package:flutter/material.dart';

class StressMode extends StatelessWidget {
  const StressMode({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Stress Mode Activated",
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
