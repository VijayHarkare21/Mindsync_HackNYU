import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class StudyMode extends StatefulWidget {
  const StudyMode({super.key});

  @override
  _StudyModeState createState() => _StudyModeState();
}

class _StudyModeState extends State<StudyMode> {
  late Timer _timer;
  final Random _random = Random();
  List<double> _brainwaveData = List.generate(50, (index) => 0.0); // Simulated brainwave values

  // Example data: Replace this with real EEG data
  int totalStudyTime = 60; // Minutes
  int alphaTime = 20;
  int betaTime = 15;
  int gammaTime = 10;
  int thetaTime = 8;
  int deltaTime = 5;
  int distractedTime = 12;

  @override
  void initState() {
    super.initState();
    _startBrainwaveSimulation();
  }

  void _startBrainwaveSimulation() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _brainwaveData.removeAt(0);
        _brainwaveData.add(_random.nextDouble() * 10); // Random values to simulate waves
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Study Mode")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Brainwave Activity Simulation",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // ✅ Brainwave Animation
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.lightBlue.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: CustomPaint(
                size: const Size(double.infinity, 150),
                painter: BrainwavePainter(_brainwaveData),
              ),
            ),

            const SizedBox(height: 20),

            // ✅ Study Time Breakdown
            const Text(
              "Study Session Analysis",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            _buildStudyStat("Total Study Time", "$totalStudyTime mins", Colors.blue),
            _buildStudyStat("Alpha State", "$alphaTime mins", Colors.green),
            _buildStudyStat("Beta State", "$betaTime mins", Colors.orange),
            _buildStudyStat("Gamma State", "$gammaTime mins", Colors.purple),
            _buildStudyStat("Theta State", "$thetaTime mins", Colors.red),
            _buildStudyStat("Delta State", "$deltaTime mins", Colors.indigo),
            _buildStudyStat("Distraction Time", "$distractedTime mins", Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildStudyStat(String label, String value, Color color) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontSize: 16)),
            Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 5),
        LinearProgressIndicator(
          value: int.parse(value.split(" ")[0]) / totalStudyTime,
          color: color,
          backgroundColor: color.withOpacity(0.3),
          minHeight: 10,
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}

// ✅ Brainwave Painter (Simulated Animation)
class BrainwavePainter extends CustomPainter {
  final List<double> data;

  BrainwavePainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blueAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    for (int i = 0; i < data.length; i++) {
      final x = i * (size.width / data.length);
      final y = size.height / 2 - data[i] * 5;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(BrainwavePainter oldDelegate) => true;
}
