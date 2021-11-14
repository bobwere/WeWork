import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work/app.dart';
import 'package:we_work/common/wework_bloc_observer.dart';
import 'package:device_preview/device_preview.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  //set blocobserver to log monitor state changes
  Bloc.observer = WeWorkBlocObserver();

  //run application
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => App(), // Wrap your app
    ),
  );
}
