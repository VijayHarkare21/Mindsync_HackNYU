import 'package:flutter/material.dart';

class MoodWheelCard extends StatelessWidget {
  const MoodWheelCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(15),
      decoration: _boxDecoration(),
      child: Column(
        children: [
          const Text("Mood Analysis", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Image.asset("assets/images/mood_wheel.png", height: 100), // Replace with an actual mood wheel image
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
