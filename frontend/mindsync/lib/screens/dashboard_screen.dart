import 'package:flutter/material.dart';
import 'detailed_dashboard_screen.dart';
import '../widgets/app_background.dart';
import '../widgets/app_header.dart';
import '../widgets/eeg_analysis_slider.dart';
import '../widgets/article_preview_card.dart';
import '../widgets/primary_button.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppHeader(), // MindSync Title
            const SizedBox(height: 20),

            // Weekly Mood & Stress Analysis (Scrollable Slider)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Weekly Mood & Stress Analysis",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            EEGAnalysisSlider(), // ✅ Removed `const` to avoid duplicate GlobalKey issue

            const SizedBox(height: 20),

            // Mindfulness Articles Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Recommended Articles",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  ArticlePreviewCard(
                    title: "5-Minute Breathing Exercises for Stress Relief",
                    description: "Learn quick and effective breathing exercises to reduce stress...",
                    onTap: () => Navigator.pushNamed(context, '/articles'),
                  ),
                  ArticlePreviewCard(
                    title: "The Power of Mindfulness in Daily Life",
                    description: "Discover how simple mindfulness techniques can improve your mental well-being...",
                    onTap: () => Navigator.pushNamed(context, '/articles'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Start a Session Button
            Center(
              child: PrimaryButton(
                text: "Start a Session",
                onPressed: () {
                  Navigator.pushNamed(context, '/detailed-dashboard');
                },
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
