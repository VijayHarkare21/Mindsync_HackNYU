import 'package:flutter/material.dart';

class DailyScorecard extends StatelessWidget {
  const DailyScorecard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(15),
      decoration: _boxDecoration(),
      child: Column(
        children: [
          const Text("Daily Scorecard", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _scoreRow("Stress Level", "Low", Colors.green),
          _scoreRow("Focus Level", "High", Colors.blue),
          _scoreRow("Relaxation", "Moderate", Colors.orange),
        ],
      ),
    );
  }

  Widget _scoreRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          Chip(label: Text(value), backgroundColor: color.withOpacity(0.2)),
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
