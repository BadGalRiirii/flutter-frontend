import 'dart:convert';
import 'package:frontend_app/constants/api.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<bool> login(String uname, String pass) async {
  final ApiRoutes apiRoutes = ApiRoutes();
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  final response = await http.post(
    Uri.parse(apiRoutes.loginRoute),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'username': uname,
      'password': pass
    })
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    await secureStorage.write(
        key: 'auth_tokens',
        value: jsonEncode({
          'access_token': data['access'],
          'refresh_token': data['refresh']
        })
    );
  }

  return response.statusCode == 200;
}

Future<bool> logout() async {
  final ApiRoutes apiRoutes = ApiRoutes();
  final FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
  var res = true;
  try {
    await flutterSecureStorage.delete(key: 'auth_tokens');
  } catch (e) {
    res = false;
  }
  return res;
}