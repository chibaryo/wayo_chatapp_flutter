
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/selection.dart';

getParent () {
  return FirebaseFirestore.instance
    .collection("collections")
    .orderBy('itemId', descending: false)
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