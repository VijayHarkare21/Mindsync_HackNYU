import 'package:flutter/material.dart';

class StressHeatmapCard extends StatelessWidget {
  const StressHeatmapCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300, // ✅ Fixed width for horizontal scrolling
      margin: const EdgeInsets.only(right: 15), // ✅ Spacing between cards
      padding: const EdgeInsets.all(15),
      decoration: _boxDecoration(),
      child: Column(
        children: [
          const Text("Daily Stress Heatmap", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Image.asset(
            "assets/images/heatmap.png",
            height: 100,
            fit: BoxFit.contain, // ✅ Prevents overflow
            errorBuilder: (context, error, stackTrace) {
              return const Text("Heatmap image not found."); // ✅ Error handling for missing asset
            },
          ),
        ],
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white.withOpacity(0.92),
      borderRadius: BorderRadius.circular(15),
      boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5, spreadRadius: 2)],
    );
  }
}
