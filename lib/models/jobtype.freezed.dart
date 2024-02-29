// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'jobtype.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

JobType _$JobTypeFromJson(Map<String, dynamic> json) {
  return _JobType.fromJson(json);
}

/// @nodoc
mixin _$JobType {
  String get job => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JobTypeCopyWith<JobType> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JobTypeCopyWith<$Res> {
  factory $JobTypeCopyWith(JobType value, $Res Function(JobType) then) =
      _$JobTypeCopyWithImpl<$Res, JobType>;
  @useResult
  $Res call(
      {String job, String label, @TimestampConverter() DateTime? createdAt});
}

/// @nodoc
class _$JobTypeCopyWithImpl<$Res, $Val extends JobType>
    implements $JobTypeCopyWith<$Res> {
  _$JobTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? job = null,
    Object? label = null,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      job: null == job
          ? _value.job
          : job // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$JobTypeImplCopyWith<$Res> implements $JobTypeCopyWith<$Res> {
  factory _$$JobTypeImplCopyWith(
          _$JobTypeImpl value, $Res Function(_$JobTypeImpl) then) =
      __$$JobTypeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String job, String label, @TimestampConverter() DateTime? createdAt});
}

/// @nodoc
class __$$JobTypeImplCopyWithImpl<$Res>
    extends _$JobTypeCopyWithImpl<$Res, _$JobTypeImpl>
    implements _$$JobTypeImplCopyWith<$Res> {
  __$$JobTypeImplCopyWithImpl(
      _$JobTypeImpl _value, $Res Function(_$JobTypeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? job = null,
    Object? label = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$JobTypeImpl(
      job: null == job
          ? _value.job
          : job // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$JobTypeImpl with DiagnosticableTreeMixin implements _JobType {
  const _$JobTypeImpl(
      {this.job = '', this.label = '', @TimestampConverter() this.createdAt});

  factory _$JobTypeImpl.fromJson(Map<String, dynamic> json) =>
      _$$JobTypeImplFromJson(json);

  @override
  @JsonKey()
  final String job;
  @override
  @JsonKey()
  final String label;
  @override
  @TimestampConverter()
  final DateTime? createdAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'JobType(job: $job, label: $label, createdAt: $createdAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'JobType'))
      ..add(DiagnosticsProperty('job', job))
      ..add(DiagnosticsProperty('label', label))
      ..add(DiagnosticsProperty('createdAt', createdAt));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JobTypeImpl &&
            (identical(other.job, job) || other.job == job) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, job, label, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$JobTypeImplCopyWith<_$JobTypeImpl> get copyWith =>
      __$$JobTypeImplCopyWithImpl<_$JobTypeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JobTypeImplToJson(
      this,
    );
  }
}

abstract class _JobType implements JobType {
  const factory _JobType(
      {final String job,
      final String label,
      @TimestampConverter() final DateTime? createdAt}) = _$JobTypeImpl;

  factory _JobType.fromJson(Map<String, dynamic> json) = _$JobTypeImpl.fromJson;

  @override
  String get job;
  @override
  String get label;
  @override
  @TimestampConverter()
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$JobTypeImplCopyWith<_$JobTypeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
