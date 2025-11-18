import 'package:flutter/services.dart';

class BatteryDataSource {
  static const platform = MethodChannel(
    'com.example.native_device_status_with_bloc/battery',
  );

  Future<int> getBatteryLevel() async {
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      return result;
    } catch (e) {
      throw Exception('Failed to get battery level: $e');
    }
  }

  Future<String> getBatteryStatus() async {
    try {
      final String result = await platform.invokeMethod('getBatteryStatus');
      return result;
    } catch (e) {
      throw Exception('Failed to get battery status: $e');
    }
  }
}
