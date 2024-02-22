import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

part "selection.freezed.dart";
part "selection.g.dart";

class TimestampConverter implements JsonConverter<DateTime?, Timestamp?> {
  const TimestampConverter();

  @override
  DateTime? fromJson(Timestamp? json) => json?.toDate();

  @override
  Timestamp? toJson(DateTime? object) =>
      object == null ? null : Timestamp.fromDate(object);
}

@freezed
class Selection with _$Selection {
  const factory Selection({
    @Default('') String docId,
    @Default(0) int itemId,
    @Default('') String text,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? modifiedAt,
  }) = _Selection;

  // Tagからデータを取得する際の変換処理
  factory Selection.fromJson(Map<String, dynamic> json) =>
    _$SelectionFromJson(json).copyWith(
      createdAt: (json['createdAt'] as Timestamp?)?.toDate(),
      modifiedAt: (json['modifiedAt'] as Timestamp?)?.toDate(),
    );

  // DartのオブジェクトからFirebaseへ渡す際の変換処理
  Map<String, dynamic> toJson() => {
    'docId': docId,
    'itemId': itemId,
    'text': text,
    'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
    'modifiedAt': modifiedAt != null ? Timestamp.fromDate(modifiedAt!) : null,
  };
}
