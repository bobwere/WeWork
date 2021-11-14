// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'worker_details.freezed.dart';
part 'worker_details.g.dart';

@freezed
class WorkerDetails with _$WorkerDetails {
  factory WorkerDetails({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'occupation') String? occupation,
    @JsonKey(name: 'email') String? email,
    @JsonKey(name: 'bio') String? bio,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _WorkerDetails;

  factory WorkerDetails.fromJson(Map<String, dynamic> json) =>
      _$WorkerDetailsFromJson(json);
}
