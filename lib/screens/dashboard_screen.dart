import 'package:flutter/material.dart';
import 'package:frontend_app/screens/login_screen.dart';
import 'package:frontend_app/services/auth.dart';
import 'package:frontend_app/ui/app_drawer.dart';
import 'package:frontend_app/ui/button.dart';
import 'home_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.red,
        title: const Text('Dashboard'),
        centerTitle: true,
      ),
      drawer: AppDrawer(),
      body: Container(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 10,
            children: [
              AppButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                    );
                  },
                  label: 'Go to Live Sensor Data'
              ),
            ],
          ),
        ),
      )
    );
  }
}
