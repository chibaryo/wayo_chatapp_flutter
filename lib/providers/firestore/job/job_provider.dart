import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wayo_chatapp/models/jobtype.dart';
import 'package:wayo_chatapp/models/user.dart';

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
    .orderBy('job', descending: true)
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
