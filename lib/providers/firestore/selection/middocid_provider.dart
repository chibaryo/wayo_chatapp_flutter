import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wayo_chatapp/models/selection.dart';

part 'middocid_provider.g.dart';

@riverpod
class midDocIdNotifier extends _$midDocIdNotifier {
  @override
  String build () {
    return "0";
  }
}


/*final asyncMidDocIdNotifierProvider = FutureProvider.family<List<Selection>, String>((ref, parentDocId) async {
  final firestore = FirebaseFirestore.instance;

   FirebaseFirestore.instance
    .collection("selections")
    .doc(parentDocId)
    .collection("childselections")
    .orderBy("itemId", descending: false)
    .snapshots()
    .map((event) => 
      event.docs.map((e) => Selection.fromJson(e.data())).toList());


});*/