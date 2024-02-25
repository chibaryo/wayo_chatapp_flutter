import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '/../models/selection.dart';

part 'parentdocid_provider.g.dart';

@riverpod
class parentDocIdNotifier extends _$parentDocIdNotifier {

  @override
  String build() {
    return "0"; // "4B539ioTMlmfVJ2h46QJ";
  }
}

@riverpod
class AsyncParentDocIdNotifier extends _$AsyncParentDocIdNotifier {
  Future<Selection> _fetchFirstSelection() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("selections")
        .where("itemId", isEqualTo: 1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      var doc = querySnapshot.docs.first;
      return Selection.fromJson(doc.data() as Map<String, dynamic>);
    } else {
      throw Exception("No document found.");
    }
  }

  @override
  FutureOr<Selection> build() async {
    return _fetchFirstSelection();
  }
}

