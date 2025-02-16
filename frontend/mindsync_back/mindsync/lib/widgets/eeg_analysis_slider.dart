import 'package:flutter/material.dart';
import 'stress_heatmap_card.dart';
import 'daily_scorecard.dart';
import 'sleep_efficiency_card.dart';
import 'meditation_effectiveness_card.dart';
import 'mood_wheel_card.dart';

class EEGAnalysisSlider extends StatelessWidget {
  const EEGAnalysisSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250, // Adjust based on your card height
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal, // ✅ Enables horizontal scrolling
        child: Row(
          children: const [
            SizedBox(width: 20), // Space before first card
            StressHeatmapCard(),
            DailyScorecard(),
            SleepEfficiencyCard(),
            MeditationEffectivenessCard(),
            MoodWheelCard(),
            SizedBox(width: 20), // Space after last card
          ],
        ),
      ),
    );
  }
}
