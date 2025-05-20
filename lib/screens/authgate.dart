import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend_app/constants/api.dart';
import 'package:frontend_app/screens/dashboard_screen.dart';
import 'package:frontend_app/screens/login_screen.dart';
import 'package:http/http.dart' as http;

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  final ApiRoutes _apiRoutes = ApiRoutes();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<bool> loggedInCheck() async {
    final tokens = await _secureStorage.read(key: 'auth_tokens');
    if (tokens == null) return false;

    try {
      final jsonDecodedTokens = jsonDecode(tokens);
      if (jsonDecodedTokens['access_token'] == null) return false;
      final verifyRes = await http.post(
        Uri.parse(_apiRoutes.verifyTokenRoute),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'token': jsonDecodedTokens['access_token']
        }),
      );
      return verifyRes.statusCode == 200;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: loggedInCheck(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return LoginScreen();
        }

        if (snapshot.hasData && snapshot.data == true) {
          return DashboardScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}