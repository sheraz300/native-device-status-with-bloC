import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:native_device_status_with_bloc/src/feature/device_info/data/repositories/device_repository_impl.dart';
import 'device_info_event.dart';
import 'device_info_state.dart';

class DeviceInfoBloc extends Bloc<DeviceInfoEvent, DeviceInfoState> {
  final DeviceRepository repository;

  DeviceInfoBloc({required this.repository}) : super(const DeviceInfoInitial()) {
    on<FetchDeviceInfoEvent>(_onFetchDeviceInfo);
    on<RefreshDeviceInfoEvent>(_onRefreshDeviceInfo);
  }

  Future<void> _onFetchDeviceInfo(
    FetchDeviceInfoEvent event,
    Emitter<DeviceInfoState> emit,
  ) async {
    emit(const DeviceInfoLoading());
    try {
      final deviceInfo = await repository.getDeviceInfo();
      emit(DeviceInfoSuccess(deviceInfo));
    } catch (e) {
      emit(DeviceInfoError(e.toString()));
    }
  }

  Future<void> _onRefreshDeviceInfo(
    RefreshDeviceInfoEvent event,
    Emitter<DeviceInfoState> emit,
  ) async {
    emit(const DeviceInfoLoading());
    try {
      final deviceInfo = await repository.getDeviceInfo();
      emit(DeviceInfoSuccess(deviceInfo));
    } catch (e) {
      emit(DeviceInfoError(e.toString()));
    }
  }
}
