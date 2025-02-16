import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/detailed_dashboard_screen.dart';
import 'screens/session_modes_screen.dart';
import 'modes/sleep_mode.dart';
import 'modes/study_mode.dart';
import 'modes/work_mode.dart';
import 'modes/mindfulness_mode.dart';
import 'modes/stress_mode.dart';

void main() {
  runApp(const MindSyncApp());
}

class MindSyncApp extends StatelessWidget {
  const MindSyncApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MindSync',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/session-modes') {
          final String mode = settings.arguments as String;
          return MaterialPageRoute(builder: (_) => SessionModesScreen(mode: mode));
        }
        return null;
      },
      routes: {
        '/': (context) => const SplashScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/detailed-dashboard': (context) => const DetailedDashboardScreen(),
        '/sleep-mode': (context) => const SleepMode(),
        '/study-mode': (context) => const StudyMode(),
        '/work-mode': (context) => const WorkMode(),
        '/mindfulness-mode': (context) => const MindfulnessMode(),
        '/stress-mode': (context) => const StressMode(),
      },
    );
  }
}
