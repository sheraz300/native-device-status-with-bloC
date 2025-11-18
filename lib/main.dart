import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:native_device_status_with_bloc/src/feature/device_info/data/datasources/battery_data_source.dart';
import 'package:native_device_status_with_bloc/src/feature/device_info/data/repositories/device_repository_impl.dart';
import 'package:native_device_status_with_bloc/src/feature/device_info/presentation/bloc/device_info_bloc.dart';
import 'package:native_device_status_with_bloc/src/feature/device_info/presentation/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Native Device Status',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: BlocProvider(
        create: (context) => DeviceInfoBloc(
          repository: DeviceRepositoryImpl(
            batteryDataSource: BatteryDataSource(),
          ),
        ),
        child: const HomePage(),
      ),
    );
  }
}
