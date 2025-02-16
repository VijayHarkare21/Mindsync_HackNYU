import 'package:flutter/material.dart';
import '../widgets/app_background.dart';
import '../widgets/app_header.dart';

class MoodTrackerScreen extends StatelessWidget {
  const MoodTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AppBackground(
        child: Column(
          children: [
            AppHeader(),
            Spacer(),
            Text("Mood Tracker - Coming Soon!", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
