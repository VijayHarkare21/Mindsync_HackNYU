import 'package:flutter/material.dart';

class BreathingExerciseScreen extends StatelessWidget {
  const BreathingExerciseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Breathing Exercise")),
      body: const Center(
        child: Text("Practice breathing exercises for relaxation."),
      ),
    );
  }
}
