import 'package:flutter/material.dart';

class MeditationScreen extends StatelessWidget {
  const MeditationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Guided Meditation")),
      body: const Center(
        child: Text("Follow guided meditation sessions to calm your mind."),
      ),
    );
  }
}
