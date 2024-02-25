// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selection_provider.dart';

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
String _$selectionStreamHash() => r'85716153a10a6280d785bac094e9dbc65f8f309a';

/// See also [selectionStream].
@ProviderFor(selectionStream)
final selectionStreamProvider =
    AutoDisposeStreamProvider<List<Selection>>.internal(
  selectionStream,
  name: r'selectionStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectionStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SelectionStreamRef = AutoDisposeStreamProviderRef<List<Selection>>;
String _$childSelectionStreamHash() =>
    r'bf9e7dee48ce69c927c3313aa983294f542e70cd';

/// See also [childSelectionStream].
@ProviderFor(childSelectionStream)
final childSelectionStreamProvider =
    AutoDisposeStreamProvider<List<Selection>>.internal(
  childSelectionStream,
  name: r'childSelectionStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$childSelectionStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ChildSelectionStreamRef = AutoDisposeStreamProviderRef<List<Selection>>;
String _$childLimiSelectionStreamHash() =>
    r'81da6ca308f7f842356bc97573043f35cf2b8a88';

/// See also [childLimiSelectionStream].
@ProviderFor(childLimiSelectionStream)
final childLimiSelectionStreamProvider =
    AutoDisposeStreamProvider<List<Selection>>.internal(
  childLimiSelectionStream,
  name: r'childLimiSelectionStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$childLimiSelectionStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ChildLimiSelectionStreamRef
    = AutoDisposeStreamProviderRef<List<Selection>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
