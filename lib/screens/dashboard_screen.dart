import 'package:flutter/material.dart';
import 'package:frontend_app/providers/motion_provider.dart';
import 'package:frontend_app/screens/login_screen.dart';
import 'package:frontend_app/services/auth.dart';
import 'package:frontend_app/ui/app_drawer.dart';
import 'package:frontend_app/ui/button.dart';
import 'package:frontend_app/ui/motion_bar_graph.dart';
import 'package:frontend_app/ui/motion_line_chart.dart';
import 'package:frontend_app/ui/scatter_timeline.dart';
import 'package:frontend_app/widgets/sensor_chart.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String currentChart = "bar-graph";

  void changeCurrentChart(String? chart) {
    if (chart == null) {
      setState(() {
        currentChart = currentChart == "bar-graph" ? "line-chart" : "bar-graph";
      });
    } else {
      setState(() {
        currentChart = chart;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final events = context.watch<MotionProvider>().events;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.red,
        title: const Text('Dashboard'),
        centerTitle: true,
      ),
      drawer: AppDrawer(),
      // body: Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: SensorChart(data: events),
      // ),
      body: SingleChildScrollView(
        child:  Column(
          spacing: 20,
          children: [
            SizedBox(),
            SizedBox(),
            Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppButton(
                    onPressed: () {
                      changeCurrentChart('bar-graph');
                    },
                    label: 'Bar Graph',
                    color: currentChart == "bar-graph" ? Colors.green : null,
                ),
                AppButton(
                    onPressed: () {
                      changeCurrentChart('line-chart');
                    },
                    label: 'Timeline',
                  color: currentChart == "line-chart" ? Colors.green : null,
                )
              ],
            ),
            SizedBox(),
            Text(
                currentChart == "bar-graph" ? 'Motions detected per 5 minutes' : 'Motion detected timeline'
            ),
            currentChart == "bar-graph" ? motionBarGraph(context) : motionLineChart(context),
          ],
        ),
      ),
      // body: events.isEmpty
      //     ? const Center(child: Text('No data yet...'))
      //     : ListView.builder(
      //   itemCount: events.length,
      //   itemBuilder: (context, index) {
      //     final event = events[index];
      //     return ListTile(
      //       title: Text('${event.deviceId} - ${event.status}'),
      //       subtitle: Text(event.timestamp.toLocal().toString()),
      //     );
      //   },
      // ),
    );
  }

  Widget motionLineChart(BuildContext context) {
    final events = context.watch<MotionProvider>().events;
    return SizedBox(
      child: events.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        reverse: true,
        scrollDirection: Axis.horizontal,
        child: Container(
            padding: EdgeInsets.only(
                left: 40,
              right: 40
            ),
            height: 400,
            width: events.length * 5,// adjust based on number of bars
            child: MotionTimelineChart(
              motionTimestamps: events
                  .map((e) => e.timestamp)
                  .take(50)
                  .toList()
            )
        ),
      ),
    );
  }

  Widget motionBarGraph(BuildContext context) {
    final events = context.watch<MotionProvider>().events;
    return SizedBox(
      child: events.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        reverse: true,
        scrollDirection: Axis.horizontal,
        child: Container(
            padding: EdgeInsets.only(
                left: 40
            ),
            height: 450,
            width: events.length * 5, // adjust based on number of bars
            child: MotionBarChart(events: events)
        ),
      ),
    );
  }
}
