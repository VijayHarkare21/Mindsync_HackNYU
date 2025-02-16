import 'package:flutter/material.dart';

class SleepTrackerScreen extends StatelessWidget {
  const SleepTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sleep Tracker")),
      body: const Center(
        child: Text("Track your sleep patterns for better rest."),
      ),
    );
  }
}
