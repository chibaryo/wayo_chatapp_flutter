import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wayo_chatapp/models/user.dart';
import 'package:wayo_chatapp/providers/firebase/auth/auth_provider.dart';

part 'user_provider.g.dart';

///
@riverpod
FirebaseFirestore firebaseFirestore(FirebaseFirestoreRef ref) {
  return FirebaseFirestore.instance;
}

@riverpod
Stream<List<FirebaseUser>> userStream(UserStreamRef ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  return firestore
    .collection('users')
//    .where("isOnline", isEqualTo: false)
    .orderBy('lastActive', descending: true)
//    .orderBy('createdAt', descending: true)
    .withConverter<FirebaseUser?>(fromFirestore:  (ds, _) {
      final data = ds.data();
      final id = ds.id;

      if (data == null) {
        return null;
      }
      data['id'] = id;
      return FirebaseUser.fromJson(data);
    }, toFirestore: (user, _) {
      return user?.toJson() ?? {};
    })
    .snapshots()
    .map((snapshot) =>
      snapshot.docs.map((doc) => doc.data()).whereType<FirebaseUser>().toList());
}

@riverpod
Stream<List<FirebaseUser>> talkTargetUserStream(TalkTargetUserStreamRef ref, String uid) {
  print("ref.watch(currentFirebaseUserIdNotifierProvider): ${ref.watch(currentFirebaseUserIdNotifierProvider)}");

  final firestore = ref.watch(firebaseFirestoreProvider);
  return firestore
    .collection('users')
    .where("uid", isEqualTo: uid)
    .withConverter<FirebaseUser?>(fromFirestore:  (ds, _) {
      final data = ds.data();
      final id = ds.id;

      if (data == null) {
        return null;
      }
      data['id'] = id;
      return FirebaseUser.fromJson(data);
    }, toFirestore: (user, _) {
      return user?.toJson() ?? {};
    })
    .snapshots()
    .map((snapshot) =>
      snapshot.docs.map((doc) => doc.data()).whereType<FirebaseUser>().toList());
}

@riverpod
class AsyncFirebaseUserNotifier extends _$AsyncFirebaseUserNotifier {
  Future<List<FirebaseUser>> _fetchFirebaseUsers() async {
    final snapshots = await FirebaseFirestore.instance.collection('users').get();
    // データ(Map型)を取得
    return snapshots.docs.map((doc) => FirebaseUser.fromJson(doc.data())).toList();
  }

  @override
  FutureOr<List<FirebaseUser>> build() async {
    return _fetchFirebaseUsers();
  }

  // CREATE(Add)
  Future<void> addFirebaseUser({
    required String name,
    required String email,
    required String password,
    required String job,
    required String haveChildren,
    required String imagepath,
    required String lastActive,
    required bool isOnline,
    }) async {
    final serverDate = DateTime.now();

    // Set the state to loading
    state = const AsyncValue.loading();
    // Add the new FirebaseUser and reload the FirebaseUser list from the remote repository
    state = await AsyncValue.guard(() async {
      // CreateUser on Firebase
      final result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      if (result != null) {
        print("Firebase User registered successfully! uid: ${result.user?.uid}");
      }

      // Conv
//      Timestamp lastActiveTimestamp = Timestamp.fromDate(lastActive);
      var _dateFormatter = DateFormat("yyyy/MM/dd hh:mm:ss");
      final resultLastActive = _dateFormatter.parseStrict(lastActive);

      // Add to firestore
      await FirebaseFirestore.instance
      .collection("users")
      .doc(result.user?.uid)
      .set({
        "uid": result.user?.uid,
        "name": name,
        "email": email,
        "job": job,
        "haveChildren": haveChildren,
        "imagepath": imagepath,
        "lastActive": resultLastActive, //lastActive,
        "isOnline": isOnline,
        "createdAt": serverDate,
        // "modifiedAt": firebaseUser.modifiedAt
      });
      return _fetchFirebaseUsers();
    });
  }


}

@riverpod
class CurrentFirebaseUserIdNotifier extends _$CurrentFirebaseUserIdNotifier {
  @override
  String build () {
    return "";
  }
}
