import 'package:flutter/material.dart';

class DetailedDashboardScreen extends StatelessWidget {
  const DetailedDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Start a Session")),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        children: [
          _dashboardItem(context, "Sleep", Icons.nights_stay, const Color(0xFFD4E2FC)), // Light Blue
          _dashboardItem(context, "Study", Icons.menu_book, const Color(0xFFFDE2E2)), // Light Red
          _dashboardItem(context, "Work", Icons.work, const Color(0xFFFFF4D2)), // Light Yellow
          _dashboardItem(context, "Mindfulness", Icons.self_improvement, const Color(0xFFD4F6CC)), // Light Green
          _dashboardItem(context, "Stress", Icons.health_and_safety, const Color(0xFFE8D3FF)), // Light Purple
        ],
      ),
    );
  }

  Widget _dashboardItem(BuildContext context, String title, IconData icon, Color bgColor) {
    return GestureDetector(
      onTap: () {
        // ✅ Now passing the argument
        Navigator.pushNamed(context, '/session-modes', arguments: title);
      },
      child: Container(
        decoration: BoxDecoration(
          color: bgColor, // ✅ Pastel color assigned
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 2)],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.black87),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
