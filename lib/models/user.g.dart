// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FirebaseUserImpl _$$FirebaseUserImplFromJson(Map<String, dynamic> json) =>
    _$FirebaseUserImpl(
      uid: json['uid'] as String? ?? '',
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      job: json['job'] as String? ?? '',
      haveChildren: json['haveChildren'] as String? ?? '',
      imagepath: json['imagepath'] as String? ?? '',
      married_status: json['married_status'] as String? ?? '',
      lastActive:
          const TimestampConverter().fromJson(json['lastActive'] as Timestamp?),
      isOnline: json['isOnline'] as bool? ?? false,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp?),
    );

Map<String, dynamic> _$$FirebaseUserImplToJson(_$FirebaseUserImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'email': instance.email,
      'job': instance.job,
      'haveChildren': instance.haveChildren,
      'imagepath': instance.imagepath,
      'married_status': instance.married_status,
      'lastActive': const TimestampConverter().toJson(instance.lastActive),
      'isOnline': instance.isOnline,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };
