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
    r'f4fad73042b02e6b9d853f3a1bb9981332354ff9';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [childLimiSelectionStream].
@ProviderFor(childLimiSelectionStream)
const childLimiSelectionStreamProvider = ChildLimiSelectionStreamFamily();

/// See also [childLimiSelectionStream].
class ChildLimiSelectionStreamFamily
    extends Family<AsyncValue<List<Selection>>> {
  /// See also [childLimiSelectionStream].
  const ChildLimiSelectionStreamFamily();

  /// See also [childLimiSelectionStream].
  ChildLimiSelectionStreamProvider call(
    String parentId,
  ) {
    return ChildLimiSelectionStreamProvider(
      parentId,
    );
  }

  @override
  ChildLimiSelectionStreamProvider getProviderOverride(
    covariant ChildLimiSelectionStreamProvider provider,
  ) {
    return call(
      provider.parentId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'childLimiSelectionStreamProvider';
}

/// See also [childLimiSelectionStream].
class ChildLimiSelectionStreamProvider
    extends AutoDisposeStreamProvider<List<Selection>> {
  /// See also [childLimiSelectionStream].
  ChildLimiSelectionStreamProvider(
    String parentId,
  ) : this._internal(
          (ref) => childLimiSelectionStream(
            ref as ChildLimiSelectionStreamRef,
            parentId,
          ),
          from: childLimiSelectionStreamProvider,
          name: r'childLimiSelectionStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$childLimiSelectionStreamHash,
          dependencies: ChildLimiSelectionStreamFamily._dependencies,
          allTransitiveDependencies:
              ChildLimiSelectionStreamFamily._allTransitiveDependencies,
          parentId: parentId,
        );

  ChildLimiSelectionStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.parentId,
  }) : super.internal();

  final String parentId;

  @override
  Override overrideWith(
    Stream<List<Selection>> Function(ChildLimiSelectionStreamRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ChildLimiSelectionStreamProvider._internal(
        (ref) => create(ref as ChildLimiSelectionStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        parentId: parentId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Selection>> createElement() {
    return _ChildLimiSelectionStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChildLimiSelectionStreamProvider &&
        other.parentId == parentId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, parentId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ChildLimiSelectionStreamRef
    on AutoDisposeStreamProviderRef<List<Selection>> {
  /// The parameter `parentId` of this provider.
  String get parentId;
}

class _ChildLimiSelectionStreamProviderElement
    extends AutoDisposeStreamProviderElement<List<Selection>>
    with ChildLimiSelectionStreamRef {
  _ChildLimiSelectionStreamProviderElement(super.provider);

  @override
  String get parentId => (origin as ChildLimiSelectionStreamProvider).parentId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
