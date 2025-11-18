import 'package:equatable/equatable.dart';

class DeviceEntity extends Equatable {
  final String deviceName;
  final int batteryLevel;
  final String batteryStatus;

  const DeviceEntity({
    required this.deviceName,
    required this.batteryLevel,
    required this.batteryStatus,
  });

  @override
  List<Object> get props => [deviceName, batteryLevel, batteryStatus];
}
