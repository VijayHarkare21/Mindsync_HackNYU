import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class WeeklyAnalysisChart extends StatelessWidget {
  const WeeklyAnalysisChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  List<String> days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
                  return Text(days[value.toInt()], style: const TextStyle(fontSize: 12));
                },
                reservedSize: 20,
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: [
                const FlSpot(0, 3),
                const FlSpot(1, 4),
                const FlSpot(2, 2),
                const FlSpot(3, 5),
                const FlSpot(4, 3),
                const FlSpot(5, 4),
                const FlSpot(6, 2),
              ],
              isCurved: true,
              color: Colors.blue,
              barWidth: 3,
              belowBarData: BarAreaData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}
