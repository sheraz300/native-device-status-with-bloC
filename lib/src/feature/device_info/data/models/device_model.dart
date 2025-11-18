import 'package:equatable/equatable.dart';

class DeviceModel extends Equatable {
  final String deviceName;
  final int batteryLevel;
  final String batteryStatus;

  const DeviceModel({
    required this.deviceName,
    required this.batteryLevel,
    required this.batteryStatus,
  });

  @override
  List<Object> get props => [deviceName, batteryLevel, batteryStatus];
}
