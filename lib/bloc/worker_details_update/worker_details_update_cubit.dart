import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:we_work/infrastructure/repository/workers_repository.dart';

part 'worker_details_update_state.dart';
part 'worker_details_update_cubit.freezed.dart';

class WorkerDetailsUpdateCubit extends Cubit<WorkerDetailUpdateState> {
  WorkerDetailsUpdateCubit(this._workersInterface)
      : super(WorkerDetailUpdateState.initial());

  WorkersInterface _workersInterface;

  void updateWorkersDetail(
      {required int id,
      required String bio,
      required String email,
      required String name,
      required String occupation}) async {
    emit(WorkerDetailUpdateState.loading());

    final bool isConnected = await InternetConnectionChecker().hasConnection;

    if (!isConnected) {
      emit(WorkerDetailUpdateState.failure(
          'No or poor internet connection. Kindly retry again'));
      return;
    }

    try {
      await _workersInterface.updateWorkersDetails(
          id: id, bio: bio, email: email, name: name, occupation: occupation);

      emit(WorkerDetailUpdateState.success());
    } catch (e) {
      emit(WorkerDetailUpdateState.failure(
          'A server error occurred. Kindly retry again'));
    }
  }

  @override
  Future<void> close() async {
    return super.close();
  }
}
