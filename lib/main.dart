import 'package:flutter/material.dart';
import 'package:frontend_app/providers/motion_provider.dart';
import 'package:frontend_app/screens/authgate.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (_) => MotionProvider(),
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sensor App',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const AuthGate(),
    );
  }
}
