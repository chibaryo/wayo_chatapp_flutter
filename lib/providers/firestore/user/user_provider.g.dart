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
String _$talkTargetUserStreamHash() =>
    r'3f53d08c0f5a1ac3e1508c4a19eab7ab953af9f9';

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

/// See also [talkTargetUserStream].
@ProviderFor(talkTargetUserStream)
const talkTargetUserStreamProvider = TalkTargetUserStreamFamily();

/// See also [talkTargetUserStream].
class TalkTargetUserStreamFamily
    extends Family<AsyncValue<List<FirebaseUser>>> {
  /// See also [talkTargetUserStream].
  const TalkTargetUserStreamFamily();

  /// See also [talkTargetUserStream].
  TalkTargetUserStreamProvider call(
    String uid,
  ) {
    return TalkTargetUserStreamProvider(
      uid,
    );
  }

  @override
  TalkTargetUserStreamProvider getProviderOverride(
    covariant TalkTargetUserStreamProvider provider,
  ) {
    return call(
      provider.uid,
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
  String? get name => r'talkTargetUserStreamProvider';
}

/// See also [talkTargetUserStream].
class TalkTargetUserStreamProvider
    extends AutoDisposeStreamProvider<List<FirebaseUser>> {
  /// See also [talkTargetUserStream].
  TalkTargetUserStreamProvider(
    String uid,
  ) : this._internal(
          (ref) => talkTargetUserStream(
            ref as TalkTargetUserStreamRef,
            uid,
          ),
          from: talkTargetUserStreamProvider,
          name: r'talkTargetUserStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$talkTargetUserStreamHash,
          dependencies: TalkTargetUserStreamFamily._dependencies,
          allTransitiveDependencies:
              TalkTargetUserStreamFamily._allTransitiveDependencies,
          uid: uid,
        );

  TalkTargetUserStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uid,
  }) : super.internal();

  final String uid;

  @override
  Override overrideWith(
    Stream<List<FirebaseUser>> Function(TalkTargetUserStreamRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TalkTargetUserStreamProvider._internal(
        (ref) => create(ref as TalkTargetUserStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uid: uid,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<FirebaseUser>> createElement() {
    return _TalkTargetUserStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TalkTargetUserStreamProvider && other.uid == uid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TalkTargetUserStreamRef
    on AutoDisposeStreamProviderRef<List<FirebaseUser>> {
  /// The parameter `uid` of this provider.
  String get uid;
}

class _TalkTargetUserStreamProviderElement
    extends AutoDisposeStreamProviderElement<List<FirebaseUser>>
    with TalkTargetUserStreamRef {
  _TalkTargetUserStreamProviderElement(super.provider);

  @override
  String get uid => (origin as TalkTargetUserStreamProvider).uid;
}

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
String _$currentFirebaseUserIdNotifierHash() =>
    r'deaaffbf66bcd156f0574e3d64f8a1eb635cf00d';

/// See also [CurrentFirebaseUserIdNotifier].
@ProviderFor(CurrentFirebaseUserIdNotifier)
final currentFirebaseUserIdNotifierProvider =
    AutoDisposeNotifierProvider<CurrentFirebaseUserIdNotifier, String>.internal(
  CurrentFirebaseUserIdNotifier.new,
  name: r'currentFirebaseUserIdNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentFirebaseUserIdNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentFirebaseUserIdNotifier = AutoDisposeNotifier<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
