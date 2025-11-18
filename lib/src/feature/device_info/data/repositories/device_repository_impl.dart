import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:native_device_status_with_bloc/src/feature/device_info/data/datasources/battery_data_source.dart';
import 'package:native_device_status_with_bloc/src/feature/device_info/domain/entities/device_entity.dart';

abstract class DeviceRepository {
  Future<DeviceEntity> getDeviceInfo();
}

class DeviceRepositoryImpl implements DeviceRepository {
  final BatteryDataSource batteryDataSource;
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  DeviceRepositoryImpl({required this.batteryDataSource});

  @override
  Future<DeviceEntity> getDeviceInfo() async {
    try {
      final batteryLevel = await batteryDataSource.getBatteryLevel();
      final batteryStatus = await batteryDataSource.getBatteryStatus();
      
      String deviceName = '';
      
      if (defaultTargetPlatform == TargetPlatform.android) {
        final androidInfo = await _deviceInfo.androidInfo;
        deviceName = '${androidInfo.manufacturer} ${androidInfo.model}';
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        final iosInfo = await _deviceInfo.iosInfo;
        deviceName = iosInfo.model;
      }

      return DeviceEntity(
        deviceName: deviceName,
        batteryLevel: batteryLevel,
        batteryStatus: batteryStatus,
      );
    } catch (e) {
      throw Exception('Failed to get device info: $e');
    }
  }
}
