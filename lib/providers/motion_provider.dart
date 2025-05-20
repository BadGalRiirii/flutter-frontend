import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend_app/constants/api.dart';
import 'package:http/http.dart' as http;

class MotionProvider extends ChangeNotifier {
  final ApiRoutes _apiRoutes = ApiRoutes();
  final FlutterSecureStorage _flutterSecureStorage = FlutterSecureStorage();

  List<MotionEvent> _events = [];
  Timer? _pollingTimer;

  List<MotionEvent> get events => _events;

  MotionProvider() {
    _startPolling();
  }

  void _startPolling() {
    _pollingTimer = Timer.periodic(const Duration(seconds: 2), (_) => fetchEvents());
  }

  Future<void> fetchEvents() async {
    try {
      final authTokens = await _flutterSecureStorage.read(key: 'auth_tokens');
      if (authTokens == null) throw 'no auth';
      final authTokenDecoded = jsonDecode(authTokens);
      final response = await http.get(
        Uri.parse(_apiRoutes.getMotionData),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${authTokenDecoded['access_token']}',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _events = data.map((json) => MotionEvent.fromJson(json)).toList();
        notifyListeners();
      } else {
        if (kDebugMode) {
          print('Failed to fetch: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching data: $e');
      }
    }
  }

  @override
  void dispose() {
    _pollingTimer?.cancel();
    super.dispose();
  }
}

class MotionEvent  {
  final String deviceId;
  final String status;
  final DateTime timestamp;

  MotionEvent({
    required this.deviceId,
    required this.status,
    required this.timestamp
  });

  factory MotionEvent.fromJson(Map<String, dynamic> json) {
    return MotionEvent(
        deviceId: json['device_id'] ?? 'Unknown',
        status: json['status'],
        timestamp: DateTime.parse(json['timestamp'])
    );
  }
}

// class CounterProvider extends ChangeNotifier {
//   int _count = 0;
//
//   int get count => _count;
//
//   void increment() {
//     _count++;
//     notifyListeners(); // Notifies all listening widgets
//   }
//
//   void reset() {
//     _count = 0;
//     notifyListeners();
//   }
// }
