import 'package:flutter/material.dart';
import 'package:frontend_app/screens/login_screen.dart';
import 'package:frontend_app/services/auth.dart';
import 'package:frontend_app/ui/button.dart';
import 'home_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  Future<bool> _handleLogout() async {
    final res = await logout();
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
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
            AppButton(
                onPressed: () async {
                  final ok = await _handleLogout();
                  if (ok && context.mounted) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  }
                },
                label: 'Logout'
            ),
          ],
        ),
      )
    );
  }
}
