// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_provider.dart';

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
String _$userStreamHash() => r'239aa3a56bd4afc68b7e67e915ca290a7b7a0e2d';

/// See also [userStream].
@ProviderFor(userStream)
final userStreamProvider =
    AutoDisposeStreamProvider<List<FirebaseUser>>.internal(
  userStream,
  name: r'userStreamProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserStreamRef = AutoDisposeStreamProviderRef<List<FirebaseUser>>;
String _$asyncFirebaseUserNotifierHash() =>
    r'6f5377fab5390ed9f05ba1e59cee673d649f6907';

/// See also [AsyncFirebaseUserNotifier].
@ProviderFor(AsyncFirebaseUserNotifier)
final asyncFirebaseUserNotifierProvider = AutoDisposeAsyncNotifierProvider<
    AsyncFirebaseUserNotifier, List<FirebaseUser>>.internal(
  AsyncFirebaseUserNotifier.new,
  name: r'asyncFirebaseUserNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$asyncFirebaseUserNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AsyncFirebaseUserNotifier
    = AutoDisposeAsyncNotifier<List<FirebaseUser>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
