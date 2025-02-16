import 'package:flutter/material.dart';
import 'dart:async';
import 'dashboard_screen.dart';
import '../widgets/app_background.dart';
import '../widgets/app_header.dart';

class PairEarbudsScreen extends StatefulWidget {
  const PairEarbudsScreen({super.key});

  @override
  _PairEarbudsScreenState createState() => _PairEarbudsScreenState();
}

class _PairEarbudsScreenState extends State<PairEarbudsScreen>
    with SingleTickerProviderStateMixin {
  bool isPaired = false;

  @override
  void initState() {
    super.initState();

    // Simulate pairing process after 3 seconds
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isPaired = true;
      });

      // After showing ✅, navigate to Dashboard after 2 seconds
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: Column(
          children: [
            const AppHeader(), // MindSync title
            const Spacer(),
            _buildPairingAnimation(),
            const SizedBox(height: 20),
            Text(
              isPaired ? "Paired Successfully!" : "Pairing with your earbuds...",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildPairingAnimation() {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Floating earbuds image
          AnimatedContainer(
            duration: const Duration(seconds: 2),
            curve: Curves.easeInOut,
            height: isPaired ? 0 : 200, // Hide earbuds after pairing
            child: Image.asset('assets/images/earbuds.png', height: 150),

          ),

          // Tick Icon ✅ (Appears after pairing)
          if (isPaired)
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 100,
            ),
        ],
      ),
    );
  }
}
