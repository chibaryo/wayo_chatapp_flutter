// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jobtype.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$JobTypeImpl _$$JobTypeImplFromJson(Map<String, dynamic> json) =>
    _$JobTypeImpl(
      job: json['job'] as String? ?? '',
      label: json['label'] as String? ?? '',
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp?),
    );

Map<String, dynamic> _$$JobTypeImplToJson(_$JobTypeImpl instance) =>
    <String, dynamic>{
      'job': instance.job,
      'label': instance.label,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };
