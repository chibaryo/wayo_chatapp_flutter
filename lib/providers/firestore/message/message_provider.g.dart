// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_provider.dart';

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
String _$messageStreamHash() => r'b53f9917e1dd53f806c4a30c71a0d4fd3668200f';

/// See also [messageStream].
@ProviderFor(messageStream)
final messageStreamProvider = AutoDisposeStreamProvider<List<Message>>.internal(
  messageStream,
  name: r'messageStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$messageStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MessageStreamRef = AutoDisposeStreamProviderRef<List<Message>>;
String _$conversationStreamHash() =>
    r'9fdd093dad586acd6d6c191cb26a0ecaf00d9cd6';

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

/// See also [conversationStream].
@ProviderFor(conversationStream)
const conversationStreamProvider = ConversationStreamFamily();

/// See also [conversationStream].
class ConversationStreamFamily extends Family<AsyncValue<List<Message>>> {
  /// See also [conversationStream].
  const ConversationStreamFamily();

  /// See also [conversationStream].
  ConversationStreamProvider call(
    String uid,
  ) {
    return ConversationStreamProvider(
      uid,
    );
  }

  @override
  ConversationStreamProvider getProviderOverride(
    covariant ConversationStreamProvider provider,
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
  String? get name => r'conversationStreamProvider';
}

/// See also [conversationStream].
class ConversationStreamProvider
    extends AutoDisposeStreamProvider<List<Message>> {
  /// See also [conversationStream].
  ConversationStreamProvider(
    String uid,
  ) : this._internal(
          (ref) => conversationStream(
            ref as ConversationStreamRef,
            uid,
          ),
          from: conversationStreamProvider,
          name: r'conversationStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$conversationStreamHash,
          dependencies: ConversationStreamFamily._dependencies,
          allTransitiveDependencies:
              ConversationStreamFamily._allTransitiveDependencies,
          uid: uid,
        );

  ConversationStreamProvider._internal(
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
    Stream<List<Message>> Function(ConversationStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ConversationStreamProvider._internal(
        (ref) => create(ref as ConversationStreamRef),
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
  AutoDisposeStreamProviderElement<List<Message>> createElement() {
    return _ConversationStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ConversationStreamProvider && other.uid == uid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ConversationStreamRef on AutoDisposeStreamProviderRef<List<Message>> {
  /// The parameter `uid` of this provider.
  String get uid;
}

class _ConversationStreamProviderElement
    extends AutoDisposeStreamProviderElement<List<Message>>
    with ConversationStreamRef {
  _ConversationStreamProviderElement(super.provider);

  @override
  String get uid => (origin as ConversationStreamProvider).uid;
}

String _$asyncMessageNotifierHash() =>
    r'6ab196c94e335606cb253288208ef89ebd37eea1';

/// See also [AsyncMessageNotifier].
@ProviderFor(AsyncMessageNotifier)
final asyncMessageNotifierProvider = AutoDisposeAsyncNotifierProvider<
    AsyncMessageNotifier, List<Message>>.internal(
  AsyncMessageNotifier.new,
  name: r'asyncMessageNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$asyncMessageNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AsyncMessageNotifier = AutoDisposeAsyncNotifier<List<Message>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
