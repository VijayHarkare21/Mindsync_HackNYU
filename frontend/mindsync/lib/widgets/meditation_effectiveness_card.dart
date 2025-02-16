import 'package:flutter/material.dart';

class MeditationEffectivenessCard extends StatelessWidget {
  const MeditationEffectivenessCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(15),
      decoration: _boxDecoration(),
      child: Column(
        children: [
          const Text("Meditation Effectiveness", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          const Text("Weekly Score: 78/100"),
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
