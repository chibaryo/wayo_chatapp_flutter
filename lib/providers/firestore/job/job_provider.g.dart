// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$firebaseFirestoreHash() => r'230b9276da2e44bb1aa6b300e1ddbb2f93c422da';

///
///
/// Copied from [firebaseFirestore].
@ProviderFor(firebaseFirestore)
final firebaseFirestoreProvider =
    AutoDisposeProvider<FirebaseFirestore>.internal(
  firebaseFirestore,
  name: r'firebaseFirestoreProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$firebaseFirestoreHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FirebaseFirestoreRef = AutoDisposeProviderRef<FirebaseFirestore>;
String _$jobStreamHash() => r'6e06ccd2a42be637e1ef67f6c94a0b5b3fb1431f';

/// See also [jobStream].
@ProviderFor(jobStream)
final jobStreamProvider = AutoDisposeStreamProvider<List<JobType>>.internal(
  jobStream,
  name: r'jobStreamProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$jobStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef JobStreamRef = AutoDisposeStreamProviderRef<List<JobType>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
