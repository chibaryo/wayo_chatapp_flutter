// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jobtype.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$JobTypeImpl _$$JobTypeImplFromJson(Map<String, dynamic> json) =>
    _$JobTypeImpl(
      id: json['id'] as String? ?? '',
      job: json['job'] as String? ?? '',
      label: json['label'] as String? ?? '',
      jobGenre: json['jobGenre'] as String? ?? '',
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp?),
    );

Map<String, dynamic> _$$JobTypeImplToJson(_$JobTypeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'job': instance.job,
      'label': instance.label,
      'jobGenre': instance.jobGenre,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };
