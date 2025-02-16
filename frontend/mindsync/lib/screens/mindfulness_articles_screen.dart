import 'package:flutter/material.dart';
import '../widgets/app_background.dart';
import '../widgets/app_header.dart';

class MindfulnessArticlesScreen extends StatelessWidget {
  const MindfulnessArticlesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AppBackground(
        child: Column(
          children: [
            AppHeader(),
            Spacer(),
            Text("Mindfulness Articles - Coming Soon!", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
