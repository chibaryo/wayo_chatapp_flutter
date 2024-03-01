import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

part "user.freezed.dart";
part "user.g.dart";

class TimestampConverter implements JsonConverter<DateTime?, Timestamp?> {
  const TimestampConverter();

  @override
  DateTime? fromJson(Timestamp? json) => json?.toDate();

  @override
  Timestamp? toJson(DateTime? object) =>
      object == null ? null : Timestamp.fromDate(object);
}

@freezed
class FirebaseUser with _$FirebaseUser {
  const factory FirebaseUser({
    @Default('') String uid,
    @Default('') String name,
    @Default('') String email,
    @Default('') String job,
    @Default('') String haveChildren,
    @Default('') String imagepath,
    @Default('') String married_status,
    @TimestampConverter() DateTime? lastActive,
    @Default(false) bool isOnline,
    @TimestampConverter() DateTime? createdAt,
  }) = _FirebaseUser;

  // Tagからデータを取得する際の変換処理
  factory FirebaseUser.fromJson(Map<String, dynamic> json) =>
    _$FirebaseUserFromJson(json).copyWith(
      createdAt: (json['createdAt'] as Timestamp?)?.toDate(),
    );

  // DartのオブジェクトからFirebaseへ渡す際の変換処理
  Map<String, dynamic> toJson() => {
    'uid': uid,
    'name': name,
    'email': email,
    'job': job,
    'haveChildren': haveChildren,
    'imagepath': imagepath,
    'married_status': married_status,
    'lastActive': lastActive != null ? Timestamp.fromDate(lastActive!) : null,
    'isOnline': isOnline,
    'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
  };
}
