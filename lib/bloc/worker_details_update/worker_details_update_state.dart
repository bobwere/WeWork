part of 'worker_details_update_cubit.dart';

@freezed
class WorkerDetailUpdateState with _$WorkerDetailUpdateState {
  const factory WorkerDetailUpdateState.initial() = Initial;
  const factory WorkerDetailUpdateState.loading() = Loading;
  const factory WorkerDetailUpdateState.success() = Success;
  const factory WorkerDetailUpdateState.failure(String failure) = Failure;
}
