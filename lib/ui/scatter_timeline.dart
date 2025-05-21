import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MotionTimelineChart extends StatelessWidget {
  final List<DateTime> motionTimestamps;

  const MotionTimelineChart({super.key, required this.motionTimestamps});

  @override
  Widget build(BuildContext context) {
    final startTime = motionTimestamps.first.toLocal();
    final spots = motionTimestamps.map((ts) {
      final secondsSinceStart = ts.toLocal().difference(startTime).inSeconds.toDouble();
      return FlSpot(secondsSinceStart, 1); // y = 1 for motion
    }).toList();
    // Use these to draw vertical lines as separate bars
    final verticalLines = spots.map((spot) {
      return LineChartBarData(
        spots: [FlSpot(spot.x, 0.85), FlSpot(spot.x, 1.15)],
        isCurved: false,
        barWidth: 1,
        color: Colors.red[700],
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
      );
    }).toList();

    return LineChart(
      LineChartData(
        lineTouchData: LineTouchData(
          enabled: true,
          handleBuiltInTouches: true,
          touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (List<LineBarSpot> touchedSpots) {
              return touchedSpots.map((spot) {
                if (spot.y != 1) return null;
                final touchedTime = startTime.add(Duration(seconds: spot.x.toInt()));
                return LineTooltipItem(
                  DateFormat('h:mm:ss a').format(touchedTime),
                  const TextStyle(color: Colors.white, fontSize: 12),
                );
              }).toList();
            }
          ),
        ),
        lineBarsData: [
          // Base thin line (can be removed if not needed)
          LineChartBarData(
            spots: spots,
            isCurved: false,
            barWidth: 1,
            color: Colors.blue.withAlpha(75),
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(show: false),
          ),
          ...verticalLines, // Vertical lines for each timestamp
        ],
        minY: 0,
        maxY: 2,
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false
            )
          ),
          rightTitles: AxisTitles(
              sideTitles: SideTitles(
                  showTitles: false
              )
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 60, // 15-min interval
              getTitlesWidget: (value, _) {
                final time = startTime.add(Duration(seconds: value.toInt()));
                return Text(DateFormat('h:mm a').format(time), style: const TextStyle(fontSize: 10));
              },
              reservedSize: 32,
            ),
          ),
        ),
        gridData: FlGridData(
            show: true
        ),
        borderData: FlBorderData(
            show: true,
          border: Border.all(
            color: Colors.black.withAlpha(25)
          )
        ),
      ),
    );
  }
}
