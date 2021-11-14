import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:we_work/infrastructure/model/worker_details.dart';
import 'package:we_work/infrastructure/repository/workers_repository.dart';

part 'worker_details_state.dart';
part 'worker_details_cubit.freezed.dart';

class WorkerDetailsCubit extends Cubit<WorkerDetailState> {
  WorkerDetailsCubit(this._workersInterface)
      : super(WorkerDetailState.initial());

  WorkersInterface _workersInterface;

  List<WorkerDetails> listOfWorkerDetails = [];

  void fetchAllWorkersDetails() async {
    emit(WorkerDetailState.loading());

    try {
      listOfWorkerDetails = await _workersInterface.getAllWorkersDetails();

      emit(WorkerDetailState.success(listOfWorkerDetails));
    } on SocketException {
      emit(WorkerDetailState.failure(
          'No or poor internet connection. Kindly retry again'));
    } catch (e) {
      emit(WorkerDetailState.failure(
          'A server error occurred. Kindly retry again'));
    }
  }

  void updateAllWorkersDetails({required WorkerDetails workerDetails}) {
    emit(WorkerDetailState.loading());
    WorkerDetails _workerDetails = listOfWorkerDetails
        .firstWhere((detail) => detail.id == workerDetails.id);

    listOfWorkerDetails[listOfWorkerDetails.indexOf(_workerDetails)] =
        workerDetails;

    emit(WorkerDetailState.success(listOfWorkerDetails));
  }

  @override
  Future<void> close() async {
    return super.close();
  }
}
