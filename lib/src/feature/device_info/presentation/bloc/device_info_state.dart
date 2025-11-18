import 'package:equatable/equatable.dart';
import 'package:native_device_status_with_bloc/src/feature/device_info/domain/entities/device_entity.dart';

abstract class DeviceInfoState extends Equatable {
  const DeviceInfoState();

  @override
  List<Object> get props => [];
}

class DeviceInfoInitial extends DeviceInfoState {
  const DeviceInfoInitial();
}

class DeviceInfoLoading extends DeviceInfoState {
  const DeviceInfoLoading();
}

class DeviceInfoSuccess extends DeviceInfoState {
  final DeviceEntity deviceInfo;

  const DeviceInfoSuccess(this.deviceInfo);

  @override
  List<Object> get props => [deviceInfo];
}

class DeviceInfoError extends DeviceInfoState {
  final String message;

  const DeviceInfoError(this.message);

  @override
  List<Object> get props => [message];
}
