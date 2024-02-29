import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

part "jobtype.freezed.dart";
part "jobtype.g.dart";

class TimestampConverter implements JsonConverter<DateTime?, Timestamp?> {
  const TimestampConverter();

  @override
  DateTime? fromJson(Timestamp? json) => json?.toDate();

  @override
  Timestamp? toJson(DateTime? object) =>
      object == null ? null : Timestamp.fromDate(object);
}

@freezed
class JobType with _$JobType {
  const factory JobType({
    @Default('') String job,
    @Default('') String label,
    @TimestampConverter() DateTime? createdAt,
  }) = _JobType;

  // Tagからデータを取得する際の変換処理
  factory JobType.fromJson(Map<String, dynamic> json) =>
    _$JobTypeFromJson(json).copyWith(
      createdAt: (json['createdAt'] as Timestamp?)?.toDate(),
    );

  // DartのオブジェクトからFirebaseへ渡す際の変換処理
  Map<String, dynamic> toJson() => {
    'job': job,
    'label': label,
    'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
  };
}
