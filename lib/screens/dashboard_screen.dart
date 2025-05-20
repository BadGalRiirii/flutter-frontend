import 'package:flutter/material.dart';
import 'package:frontend_app/providers/motion_provider.dart';
import 'package:frontend_app/screens/login_screen.dart';
import 'package:frontend_app/services/auth.dart';
import 'package:frontend_app/ui/app_drawer.dart';
import 'package:frontend_app/ui/button.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

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
      body: events.isEmpty
          ? const Center(child: Text('No data yet...'))
          : ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return ListTile(
            title: Text('${event.deviceId} - ${event.status}'),
            subtitle: Text(event.timestamp.toLocal().toString()),
          );
        },
      ),
    );
  }
}
