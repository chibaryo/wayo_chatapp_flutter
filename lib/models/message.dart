import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

part "message.freezed.dart";
part "message.g.dart";

class TimestampConverter implements JsonConverter<DateTime?, Timestamp?> {
  const TimestampConverter();

  @override
  DateTime? fromJson(Timestamp? json) => json?.toDate();

  @override
  Timestamp? toJson(DateTime? object) =>
      object == null ? null : Timestamp.fromDate(object);
}

enum MessageType {
  text,
  image;
}

@freezed
class Message with _$Message {
  const factory Message({
    @Default('') String messageId,
    @Default('') String senderUid,
    @Default('') String receiverUid,
    @Default('') String content,
    @Default(MessageType.text) MessageType messageType,
    @TimestampConverter() DateTime? createdAt,
  }) = _Message;

  // Tagからデータを取得する際の変換処理
  factory Message.fromJson(Map<String, dynamic> json) =>
    _$MessageFromJson(json).copyWith(
      createdAt: (json['createdAt'] as Timestamp?)?.toDate(),
    );

  // DartのオブジェクトからFirebaseへ渡す際の変換処理
  Map<String, dynamic> toJson() => {
    'messageId': messageId,
    'senderUid': senderUid,
    'receiverUid': receiverUid,
    'content': content,
    'messageType': messageType,
    'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
  };
}
