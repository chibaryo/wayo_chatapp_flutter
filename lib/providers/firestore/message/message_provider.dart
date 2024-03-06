import 'dart:developer';

import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';

import '../../../models/message.dart';

part 'message_provider.g.dart';

///
@riverpod
FirebaseFirestore firebaseFirestore(FirebaseFirestoreRef ref) {
  return FirebaseFirestore.instance;
}

@riverpod
Stream<List<Message>> messageStream(MessageStreamRef ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  return firestore
    .collection('messages')
//    .where("isOnline", isEqualTo: false)
    .orderBy('createdAt', descending: true)
//    .orderBy('createdAt', descending: true)
    .withConverter<Message?>(fromFirestore:  (ds, _) {
      final data = ds.data();
      final id = ds.id;

      if (data == null) {
        return null;
      }
      data['id'] = id;
      return Message.fromJson(data);
    }, toFirestore: (user, _) {
      return user?.toJson() ?? {};
    })
    .snapshots()
    .map((snapshot) =>
      snapshot.docs.map((doc) => doc.data()).whereType<Message>().toList());
}

//
@riverpod
Stream<List<Message>> conversationStream(ConversationStreamRef ref, String uid) {
  final firestore = ref.watch(firebaseFirestoreProvider);

  final senderStream = firestore
    .collection('messages')
    .where("senderUid", isEqualTo: uid)
    .orderBy('createdAt', descending: false)
    .withConverter<Message?>(fromFirestore:  (ds, _) {
      final data = ds.data();
      final id = ds.id;

      if (data == null) {
        return null;
      }
      data['id'] = id;
      return Message.fromJson(data);
    }, toFirestore: (user, _) {
      return user?.toJson() ?? {};
    })
    .snapshots()
    .map((snapshot) =>
      snapshot.docs.map((doc) => doc.data()).whereType<Message>().toList());

  final receiverStream = firestore
    .collection('messages')
    .where("receiverUid", isEqualTo: uid)
    .orderBy('createdAt', descending: false)
    .withConverter<Message?>(fromFirestore:  (ds, _) {
      final data = ds.data();
      final id = ds.id;

      if (data == null) {
        return null;
      }
      data['id'] = id;
      return Message.fromJson(data);
    }, toFirestore: (user, _) {
      return user?.toJson() ?? {};
    })
    .snapshots()
    .map((snapshot) =>
      snapshot.docs.map((doc) => doc.data()).whereType<Message>().toList());

  final mergedStream = Rx.combineLatest2(
    senderStream,
    receiverStream,
    (List<Message> a, List<Message> b) => a + b,
  );
  // Sort
  return mergedStream;
}

//
@riverpod
class AsyncMessageNotifier extends _$AsyncMessageNotifier {
  Future<List<Message>> _fetchMessages() async {
    final snapshots = await FirebaseFirestore.instance
      .collection('messages')
      .get();
    // データ(Map型)を取得
    return snapshots.docs.map((doc) => Message.fromJson(doc.data())).toList();
  }

  @override
  FutureOr<List<Message>> build() async {
    return _fetchMessages();
  }

  // Get by uid
  Future<List<Message>> fetchMessagesbyUid(String uid) async {
    final snapshots_me = await FirebaseFirestore.instance
      .collection("messages")
      .where("senderUid", isEqualTo: uid)
      .get();

    final snapshots_you = await FirebaseFirestore.instance
      .collection("messages")
      .where("receiverUid", isEqualTo: uid)
      .get();

    final combinedSnapshots = [...snapshots_me.docs, ...snapshots_you.docs];
    return combinedSnapshots.map((doc) => Message.fromJson(doc.data())).toList();
  }

  // CREATE(Add)
  Future<void> addMessage({
    required String messageId,
    required String senderUid,
    required String receiverUid,
    required String content,
    required MessageType messageType,
    }) async {
    final serverDate = DateTime.now();

    // Set the state to loading
    state = const AsyncValue.loading();
    // Add the new FirebaseUser and reload the FirebaseUser list from the remote repository
    state = await AsyncValue.guard(() async {

      print("messageId: $messageId");
      print("senderUid: $senderUid");
      print("receiverUid: $receiverUid");
      print("content: $content");
      print("messageType: $messageType");
      print("serverDate: $serverDate");

      // Add to firestore collection "messages"
      await FirebaseFirestore.instance
        .collection("messages")
        .doc(messageId)
        .set({
          "messageId": messageId,
          "senderUid": senderUid,
          "receiverUid": receiverUid,
          "content": content,
          "messageType": messageType.name,
          "createdAt": serverDate,
          // "modifiedAt": firebaseUser.modifiedAt
      });

      // Add to firestore "users" subcollection "myPosts"
      await FirebaseFirestore.instance
        .collection("users")
        .doc(senderUid)
        .collection("myPosts")
        .doc(messageId)
        .set({
          "uid": senderUid,
          "createdAt": serverDate,
      });

      return _fetchMessages();
    });
  }

  // DELETE (from each user's myPosts and messages)
  Future<void> deleteMessage({
    required String messageId,
    required String senderUid,
    required MessageType messageType,
    required String content,
    }) async {
    // Set the state to loading
    state = const AsyncValue.loading();
    // Add the new FirebaseUser and reload the FirebaseUser list from the remote repository
    state = await AsyncValue.guard(() async {
      await FirebaseFirestore.instance
        .collection("users")
        .doc(senderUid)
        .collection("myPosts")
        .doc(messageId)
        .delete();

      await FirebaseFirestore.instance
        .collection("messages")
        .doc(messageId)
        .delete();

      // If MessageType.image, then also remove image from CloudStorage
      if (messageType == MessageType.image) {
        final storageRef = FirebaseStorage.instance.refFromURL(content);
        await storageRef.delete();
      }

      return _fetchMessages();
    });
  }

}

