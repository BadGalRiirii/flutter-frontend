import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:frontend_app/providers/motion_provider.dart';

class MotionLineChart extends StatelessWidget {
  final List<MotionEvent> events;

  const MotionLineChart({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    final spots = events.map((e) {
      return FlSpot(e.timestamp.millisecondsSinceEpoch.toDouble(), e.status.toDouble());
    }).toList();

    return LineChart(
      LineChartData(
        minY: 0,
        maxY: 1,
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (val, _) => Text(val == 1 ? 'Motion' : 'None', style: const TextStyle(fontSize: 10)),
              interval: 1,
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: (spots.length / 5).floorToDouble().clamp(1, double.infinity),
              getTitlesWidget: (val, meta) {
                final date = DateTime.fromMillisecondsSinceEpoch(val.toInt());
                return Text('${date.hour}:${date.minute}', style: const TextStyle(fontSize: 10));
              },
            ),
          ),
        ),
        gridData: FlGridData(show: true),
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: Colors.blue,
            barWidth: 2,
            dotData: FlDotData(show: true),
          ),
        ],
      ),
    );
  }
}
