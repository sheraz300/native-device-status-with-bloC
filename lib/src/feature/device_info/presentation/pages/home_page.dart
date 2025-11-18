import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:native_device_status_with_bloc/src/feature/device_info/presentation/bloc/device_info_bloc.dart';
import 'package:native_device_status_with_bloc/src/feature/device_info/presentation/bloc/device_info_event.dart';
import 'package:native_device_status_with_bloc/src/feature/device_info/presentation/bloc/device_info_state.dart';
import 'package:native_device_status_with_bloc/src/feature/device_info/presentation/widgets/battery_indicator.dart';
import 'package:native_device_status_with_bloc/src/feature/device_info/presentation/widgets/device_info_card.dart';
import 'package:native_device_status_with_bloc/src/feature/device_info/presentation/widgets/error_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DeviceInfoBloc>().add(const FetchDeviceInfoEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Info & Battery Status'),
        elevation: 0,
      ),
      body: RefreshIndicator(
        color: Colors.green,
        onRefresh: () async {
          context.read<DeviceInfoBloc>().add(const RefreshDeviceInfoEvent());
          await Future.delayed(const Duration(milliseconds: 500));
        },
        child: BlocBuilder<DeviceInfoBloc, DeviceInfoState>(
          builder: (context, state) {
            if (state is DeviceInfoLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DeviceInfoSuccess) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      DeviceInfoCard(deviceName: state.deviceInfo.deviceName),
                      const SizedBox(height: 24),
                      BatteryIndicator(
                        batteryLevel: state.deviceInfo.batteryLevel,
                        batteryStatus: state.deviceInfo.batteryStatus,
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is DeviceInfoError) {
              return DeviceErrorWidget(
                message: state.message,
                onRetry: () {
                  context.read<DeviceInfoBloc>().add(
                    const FetchDeviceInfoEvent(),
                  );
                },
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
