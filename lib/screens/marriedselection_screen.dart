import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:logger/logger.dart';
import 'package:wayo_chatapp/providers/cond_selections/cond_selections_provider.dart';

import '../providers/firebase/auth/auth_provider.dart';

final logger = Logger();

enum _IsMarried {
  notMarried(title: "独身（未婚）"),
  divorced(title: "独身（離婚）"),
  died(title: "独身（死別）"),
  married(title: "既婚"),
  secret(title: "ナイショ");

  final String title;

  const _IsMarried({required this.title});
}

class MarriedSelection extends HookConsumerWidget {
  const MarriedSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _selectedMarriedStatus = ref.watch(condSelectionIsMarriedNotifierProvider);
    final authState = ref.watch(firebaseAuthProvider);

    useEffect(() {}, const []);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("結婚歴"),
        backgroundColor: Colors.grey.shade100,
        actions: [
          IconButton(
            onPressed: () async {},
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
              children: [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Wrap(
          alignment: WrapAlignment.start,
          direction: Axis.vertical,
          spacing: 8.0,
          runSpacing: 4.0,
          children: _IsMarried.values.map((e) {
            return FilterChip(
              selected: _selectedMarriedStatus.contains(e.title),
              label: Text(e.title),
              onSelected: (selected) {
                if (selected) {
                  ref.read(condSelectionIsMarriedNotifierProvider.notifier).addSelection(e.title);
                } else {
                  ref.read(condSelectionIsMarriedNotifierProvider.notifier).removeSelection(e.title);
                }
              },
            );
          }).toList(),
        ),
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        width: double.infinity,
        child: Row(
          children: <Widget>[
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {},
                child: const Text("キャンセル")
              ),
            ),
            const SizedBox(width: 32,),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown.shade500,
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {
                  print(_selectedMarriedStatus);
                        await FirebaseFirestore.instance
                          .collection("preferred_filters")
                          .doc(authState.currentUser?.uid)
                          .update({
                            'married_status': FieldValue.delete()
                          })
                          .whenComplete(() => print("Field Deleted"));
                        
                        await FirebaseFirestore.instance
                          .collection("preferred_filters")
                          .doc(authState.currentUser?.uid)
                          .update({
                            'married_status': _selectedMarriedStatus
                          });

                  context.goNamed("CondScreen");
                },
                child: const Text("決定する")
              ),
            ),
          ],
        ),
      ),
              ],
            ),
    );
  }
}
