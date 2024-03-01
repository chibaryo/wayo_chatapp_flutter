import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wayo_chatapp/models/jobtype.dart';
import 'package:wayo_chatapp/models/user.dart';
import 'package:uuid/uuid.dart';

part 'job_provider.g.dart';

///
@riverpod
FirebaseFirestore firebaseFirestore(FirebaseFirestoreRef ref) {
  return FirebaseFirestore.instance;
}

@riverpod
Stream<List<JobType>> jobStream(JobStreamRef ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  return firestore
    .collection('jobs')
//    .where("isOnline", isEqualTo: false)
    .orderBy('jobGenre', descending: true)
//    .orderBy('createdAt', descending: true)
    .withConverter<JobType?>(fromFirestore:  (ds, _) {
      final data = ds.data();
      final id = ds.id;

      if (data == null) {
        return null;
      }
      data['id'] = id;
      return JobType.fromJson(data);
    }, toFirestore: (job, _) {
      return job?.toJson() ?? {};
    })
    .snapshots()
    .map((snapshot) =>
      snapshot.docs.map((doc) => doc.data()).whereType<JobType>().toList());
}

//
@riverpod
class AsyncFirebaseJobNotifier extends _$AsyncFirebaseJobNotifier {
  Future<List<JobType>> _fetchFirebaseJobs() async {
    final snapshots = await FirebaseFirestore.instance.collection('jobs').get();
    // データ(Map型)を取得
    return snapshots.docs.map((doc) => JobType.fromJson(doc.data())).toList();
  }

  @override
  FutureOr<List<JobType>> build() async {
    return _fetchFirebaseJobs();
  }

  // CREATE(Add)
  Future<void> addFirebaseJob({
    required String label,
    required String job,
    required String jobGenre,
    }) async {

    final serverDate = DateTime.now();
    var uuid = Uuid();
    var newId = uuid.v4();

    // Set the state to loading
    state = const AsyncValue.loading();
    // Add the new FirebaseUser and reload the FirebaseUser list from the remote repository
    state = await AsyncValue.guard(() async {

      // Add to firestore
      await FirebaseFirestore.instance
      .collection("jobs")
      .doc(newId)
      .set({
        "id": newId,
        "job": job,
        "label": label,
        "jobGenre": jobGenre,
        "createdAt": serverDate,
      });
      return _fetchFirebaseJobs();
    });
  }

  // Update
  Future<void> updateFirebaseJob({
    required String id,
    required String job,
    required String label,
    required String jobGenre
  }) async {
    // Set the state to loading
    state = const AsyncValue.loading();
    // Add the new FirebaseUser and reload the FirebaseUser list from the remote repository
    state = await AsyncValue.guard(() async {
      print("Hello edit! $id");

      final querySnapshots = await FirebaseFirestore.instance
        .collection("jobs")
        .where("id", isEqualTo: id)
        .get();
      
      for (var snapshot in querySnapshots.docs) {
        var docId = snapshot.id;
        print("update: docId $docId");
        await FirebaseFirestore.instance
          .collection("jobs")
          .doc(docId)
          .update({
            "job": job,
            "label": label,
            "jobGenre": jobGenre
          });
      }

      return _fetchFirebaseJobs();
    });
  }

  // Remove
  Future<void> removeFirebaseJob({
    required String job,
  }) async {
    // Set the state to loading
    state = const AsyncValue.loading();
    // Add the new FirebaseUser and reload the FirebaseUser list from the remote repository
    state = await AsyncValue.guard(() async {
      final querySnapshots = await FirebaseFirestore.instance
        .collection("jobs")
        .where("job", isEqualTo: job)
        .get();
      
      for (var snapshot in querySnapshots.docs) {
        var docId = snapshot.id;
        await FirebaseFirestore.instance
          .collection("jobs")
          .doc(docId)
          .delete();
      }

      return _fetchFirebaseJobs();
    });
  }

}
