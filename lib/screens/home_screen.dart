// import 'package:flutter/material.dart';
// import 'package:sensors_plus/sensors_plus.dart';
// import 'dart:async';
// import '../widgets/sensor_chart.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   final List<double> _xValues = [];
//   StreamSubscription? _accelSub;
//
//   @override
//   void initState() {
//     super.initState();
//     _accelSub = accelerometerEvents.listen((event) {
//       setState(() {
//         _xValues.add(event.x);
//         if (_xValues.length > 30) {
//           _xValues.removeAt(0);
//         }
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     _accelSub?.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Live Accelerometer Data")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SensorChart(data: _xValues),
//       ),
//     );
//   }
// }
