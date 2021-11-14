import 'package:dio/dio.dart';
import 'package:we_work/common/api.dart';
import 'package:we_work/infrastructure/model/worker_details.dart';

abstract class WorkersInterface {
  Future<List<WorkerDetails>> getAllWorkersDetails();
  Future<void> updateWorkersDetails(
      {required int id,
      required String bio,
      required String email,
      required String name,
      required String occupation});
}

class WorkersRepository implements WorkersInterface {
  WorkersRepository();

  @override
  Future<List<WorkerDetails>> getAllWorkersDetails() async {
    Dio dio = Dio();
    final response = await dio.get(BASE_WORKER_API_URL);

    final List<WorkerDetails> _workerDetailsList = <WorkerDetails>[];

    final List<dynamic> _workerDetailResponseList =
        response.data as List<dynamic>;

    for (final dynamic _workerDetailResponse in _workerDetailResponseList) {
      _workerDetailsList.add(WorkerDetails.fromJson(
          _workerDetailResponse as Map<String, dynamic>));
    }

    return _workerDetailsList;
  }

  @override
  Future<void> updateWorkersDetails(
      {required int id,
      required String bio,
      required String email,
      required String name,
      required String occupation}) async {
    Dio dio = Dio();
    final response = await dio.patch('$BASE_WORKER_API_URL/$id', data: {
      "bio": bio,
      "email": email,
      "name": name,
      "occupation": occupation
    });

    final Map<String, dynamic> _workerDetailResponse =
        response.data as Map<String, dynamic>;

    WorkerDetails.fromJson(_workerDetailResponse);

    return null;
  }
}
