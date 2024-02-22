// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SelectionImpl _$$SelectionImplFromJson(Map<String, dynamic> json) =>
    _$SelectionImpl(
      docId: json['docId'] as String? ?? '',
      itemId: json['itemId'] as int? ?? 0,
      text: json['text'] as String? ?? '',
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp?),
      modifiedAt:
          const TimestampConverter().fromJson(json['modifiedAt'] as Timestamp?),
    );

Map<String, dynamic> _$$SelectionImplToJson(_$SelectionImpl instance) =>
    <String, dynamic>{
      'docId': instance.docId,
      'itemId': instance.itemId,
      'text': instance.text,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'modifiedAt': const TimestampConverter().toJson(instance.modifiedAt),
    };
