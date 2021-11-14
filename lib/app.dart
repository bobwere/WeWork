import 'package:flutter/material.dart';
import 'package:we_work/bloc/worker_details_update/worker_details_update_cubit.dart';
import 'package:we_work/bloc/worker_details/worker_details_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work/infrastructure/repository/workers_repository.dart';
import 'package:we_work/presentation/pages/splash_page.dart';
import 'package:device_preview/device_preview.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => WorkerDetailsUpdateCubit(WorkersRepository())),
        BlocProvider(
            create: (context) => WorkerDetailsCubit(WorkersRepository())),
      ],
      child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              currentFocus.focusedChild!.unfocus();
            }
          },
          child: MaterialApp(
            useInheritedMediaQuery: true,
            locale: DevicePreview.locale(context),
            title: 'Incubateur',
            home: SplashPage(),
            debugShowCheckedModeBanner: false,
          )),
    );
  }
}
