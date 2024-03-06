// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageImpl _$$MessageImplFromJson(Map<String, dynamic> json) =>
    _$MessageImpl(
      messageId: json['messageId'] as String? ?? '',
      senderUid: json['senderUid'] as String? ?? '',
      receiverUid: json['receiverUid'] as String? ?? '',
      content: json['content'] as String? ?? '',
      messageType:
          $enumDecodeNullable(_$MessageTypeEnumMap, json['messageType']) ??
              MessageType.text,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp?),
    );

Map<String, dynamic> _$$MessageImplToJson(_$MessageImpl instance) =>
    <String, dynamic>{
      'messageId': instance.messageId,
      'senderUid': instance.senderUid,
      'receiverUid': instance.receiverUid,
      'content': instance.content,
      'messageType': _$MessageTypeEnumMap[instance.messageType]!,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };

const _$MessageTypeEnumMap = {
  MessageType.text: 'text',
  MessageType.image: 'image',
};
