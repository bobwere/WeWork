part of 'worker_details_cubit.dart';

@freezed
class WorkerDetailState with _$WorkerDetailState {
  const factory WorkerDetailState.initial() = Initial;
  const factory WorkerDetailState.loading() = Loading;
  const factory WorkerDetailState.success(
      List<WorkerDetails> listOfWorkerDetails) = Success;
  const factory WorkerDetailState.failure(String failure) = Failure;
}
