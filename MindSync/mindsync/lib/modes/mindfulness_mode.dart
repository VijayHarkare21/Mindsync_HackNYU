import 'package:flutter/material.dart';

class MindfulnessMode extends StatelessWidget {
  const MindfulnessMode({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Mindfulness Mode Activated",
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
