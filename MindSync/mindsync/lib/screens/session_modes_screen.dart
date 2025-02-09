import 'package:flutter/material.dart';

class SessionModesScreen extends StatelessWidget {
  final String mode;
  const SessionModesScreen({super.key, required this.mode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("$mode Mode")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome to $mode Mode",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              "Personalized experience for $mode",
              style: const TextStyle(fontSize: 18, color: Colors.black54),
            ),
            const SizedBox(height: 30),

            // ✅ Add Button to Navigate to Mode-Specific Page
            ElevatedButton(
              onPressed: () {
                String route = '/dashboard'; // Default fallback route
                switch (mode) {
                  case "Sleep":
                    route = '/sleep-mode';
                    break;
                  case "Study":
                    route = '/study-mode';
                    break;
                  case "Work":
                    route = '/work-mode';
                    break;
                  case "Mindfulness":
                    route = '/mindfulness-mode';
                    break;
                  case "Stress":
                    route = '/stress-mode';
                    break;
                }
                Navigator.pushNamed(context, route);
              },
              child: Text("Go to $mode Mode"),
            ),
          ],
        ),
      ),
    );
  }
}
