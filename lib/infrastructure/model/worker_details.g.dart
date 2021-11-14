// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'worker_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WorkerDetails _$$_WorkerDetailsFromJson(Map<String, dynamic> json) =>
    _$_WorkerDetails(
      id: json['id'] as int?,
      name: json['name'] as String?,
      occupation: json['occupation'] as String?,
      email: json['email'] as String?,
      bio: json['bio'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$$_WorkerDetailsToJson(_$_WorkerDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'occupation': instance.occupation,
      'email': instance.email,
      'bio': instance.bio,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
