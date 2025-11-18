import 'package:equatable/equatable.dart';

abstract class DeviceInfoEvent extends Equatable {
  const DeviceInfoEvent();

  @override
  List<Object> get props => [];
}

class FetchDeviceInfoEvent extends DeviceInfoEvent {
  const FetchDeviceInfoEvent();
}

class RefreshDeviceInfoEvent extends DeviceInfoEvent {
  const RefreshDeviceInfoEvent();
}
