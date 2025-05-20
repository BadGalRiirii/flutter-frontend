import 'package:frontend_app/providers/motion_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

List<Map<String, dynamic>> groupEventsBy5Minutes(List<MotionEvent> events) {
  final grouped = <DateTime, int>{};

  for (var event in events) {
    if (event.status == 1) {
      final ts = event.timestamp.toLocal();
      final interval = DateTime(
        ts.year,
        ts.month,
        ts.day,
        ts.hour,
        (ts.minute ~/ 5) * 5,
      );
      grouped.update(interval, (val) => val + 1, ifAbsent: () => 1);
    }
  }

  return grouped.entries
      .map((e) => {
    'time': e.key,
    'count': e.value,
  })
      .toList()
    ..sort((a, b) => (a['time'] as DateTime).compareTo(b['time'] as DateTime));
}

class MotionBarChart extends StatelessWidget {
  final List<MotionEvent> events;

  const MotionBarChart({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    final groupedData = groupEventsBy5Minutes(events);

    final spots = List.generate(groupedData.length, (index) {
      return BarChartRodData(
          toY: groupedData[index]['count'].toDouble(),
          color: Colors.blue,
        width: 25,
        borderRadius: BorderRadius.circular(5)
      );
    });

    return BarChart(
      BarChartData(
        barGroups: List.generate(spots.length, (index) {
          return BarChartGroupData(
              x: index,
              barRods: [spots[index]],
          );
        }),
        titlesData: FlTitlesData(
          topTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false
            )
          ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (val, _) {
                  final i = val.toInt();
                  if (i < groupedData.length) {
                    final start = groupedData[i]['time'] as DateTime;
                    final end = start.add(const Duration(minutes: 5));
                    final formatted = '${DateFormat('h:mm a').format(start)} - ${DateFormat('h:mm a').format(end)}';
                    return Padding(
                      padding: EdgeInsets.only(top: 95),
                      child: Transform.rotate(
                        angle: -1,
                        alignment: Alignment.topLeft,
                        child: Text(
                          formatted,
                          style: const TextStyle(fontSize: 10),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    );
                  }
                  return const Text('');
                },
                reservedSize: 125,
                interval: 1,
              ),
            ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
              getTitlesWidget: (val, _) => Text(val.toInt().toString(), style: const TextStyle(fontSize: 10)),
              interval: 1,
            ),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
              getTitlesWidget: (val, _) => Text(val.toInt().toString(), style: const TextStyle(fontSize: 10)),
              interval: 1,
            ),
          ),
        ),
        gridData: FlGridData(
            show: true,
            drawVerticalLine: false
        ),
        borderData: FlBorderData(
            show: false,
            border: Border.all(
              color: Colors.black.withAlpha(25)
            )
        ),
        maxY: groupedData.map((e) => e['count'] as int).reduce((a, b) => a > b ? a : b).toDouble() + 3,
      ),
    );
  }
}

