import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wayo_chatapp/models/selection.dart';
import './parentdocid_provider.dart';

part 'selection_provider.g.dart';

///
@riverpod
FirebaseFirestore firebaseFirestore(FirebaseFirestoreRef ref) {
  return FirebaseFirestore.instance;
}

@riverpod
Stream<List<Selection>> selectionStream(SelectionStreamRef ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  return firestore
    .collection('selections')
    .orderBy('itemId', descending: false)
//    .orderBy('createdAt', descending: true)
    .withConverter<Selection?>(fromFirestore:  (ds, _) {
      final data = ds.data();
      final id = ds.id;

      if (data == null) {
        return null;
      }
      data['id'] = id;
      return Selection.fromJson(data);
    }, toFirestore: (user, _) {
      return user?.toJson() ?? {};
    })
    .snapshots()
    .map((snapshot) =>
      snapshot.docs.map((doc) => doc.data()).whereType<Selection>().toList());
}

@riverpod
Stream<List<Selection>> childSelectionStream(ChildSelectionStreamRef ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  return firestore
    .collectionGroup('childselections')
    .orderBy('itemId', descending: false)
//    .orderBy('createdAt', descending: true)
    .withConverter<Selection?>(fromFirestore:  (ds, _) {
      final data = ds.data();
      final id = ds.id;
      ///print("ds.id: ${ds.id}");

      if (data == null) {
        return null;
      }
      data['id'] = id;
      return Selection.fromJson(data);
    }, toFirestore: (user, _) {
      return user?.toJson() ?? {};
    })
    .snapshots()
    .map((snapshot) =>
      snapshot.docs.map((doc) => doc.data()).whereType<Selection>().toList());
}

@riverpod
Stream<List<Selection>> childLimiSelectionStream(ChildLimiSelectionStreamRef ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);

  return firestore
    .collection('child_selections')
    .where("parentId", isEqualTo: ref.watch(parentDocIdNotifierProvider))
    .orderBy('itemId', descending: false)
//    .orderBy('createdAt', descending: true)
    .withConverter<Selection?>(fromFirestore:  (ds, _) {
      final data = ds.data();
      final id = ds.id;
      print("ds.id: ${ds.id}");

      if (data == null) {
        return null;
      }
      data['id'] = id;
      return Selection.fromJson(data);
    }, toFirestore: (user, _) {
      return user?.toJson() ?? {};
    })
    .snapshots()
    .map((snapshot) =>
      snapshot.docs.map((doc) => doc.data()).whereType<Selection>().toList());
}

// Get
Stream<List<Selection>> readChildren(String docId) async* {
  final firestore = FirebaseFirestore.instance;

  yield* firestore
    .collection("selections")
    .doc(docId)
    .collection("childselections")
    .orderBy("itemId", descending: false)
    .snapshots()
    .map((event) => 
      event.docs.map((e) => Selection.fromJson(e.data())).toList());

}

