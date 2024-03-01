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
String _$jobStreamHash() => r'abe2e15a41090cbabec888fe33880aa05a9a508d';

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
String _$asyncFirebaseJobNotifierHash() =>
    r'0b646ea6f9252251e9236942d64c5e28d8f15526';

/// See also [AsyncFirebaseJobNotifier].
@ProviderFor(AsyncFirebaseJobNotifier)
final asyncFirebaseJobNotifierProvider = AutoDisposeAsyncNotifierProvider<
    AsyncFirebaseJobNotifier, List<JobType>>.internal(
  AsyncFirebaseJobNotifier.new,
  name: r'asyncFirebaseJobNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$asyncFirebaseJobNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AsyncFirebaseJobNotifier = AutoDisposeAsyncNotifier<List<JobType>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
