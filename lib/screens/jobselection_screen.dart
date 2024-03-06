import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:logger/logger.dart';
import 'package:wayo_chatapp/providers/cond_selections/cond_selections_provider.dart';

import '../providers/firebase/auth/auth_provider.dart';
import '../providers/firestore/job/job_provider.dart';
import '../providers/firestore/user/selectedjob_provider.dart';

class JobSelection extends HookConsumerWidget {
  const JobSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(firebaseAuthProvider);

    final _selectedMarriedStatus =
        ref.watch(condSelectionIsMarriedNotifierProvider);
    final _selectedJob = ref.watch(selectedJobNotifierProvider);
    final _jobLists = ref.watch(asyncFirebaseJobNotifierProvider);

    useEffect(() {
    }, const []);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("職業"),
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
            padding: const EdgeInsets.all(8.0),
            child: _jobLists.when(
              data: (jobs) {
                return Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  direction: Axis.horizontal,
                  children: jobs.map((e) {
                    return FilterChip(
                      selected: _selectedJob.contains(e.label),
                      label: Text(e.label),
                      onSelected: (selected) {
                        if (selected) {
                          if (!ref.watch(selectedJobNotifierProvider).contains(e.label)) {
                            print("ref.watch(selectedJobNotifierProvider) : ${ref.watch(selectedJobNotifierProvider)}");
                            ref
                              .read(selectedJobNotifierProvider.notifier)
                              .addJob(e.label);
                          }
                        } else {
                          ref
                              .read(selectedJobNotifierProvider.notifier)
                              .removeJob(e.label);
                        }
                      },
                    );
                  }).toList(),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) =>
                  Center(child: Text('Error: $error')),
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
                      onPressed: () {
                        context.pop();
                      },
                      child: const Text("キャンセル")),
                ),
                const SizedBox(
                  width: 32,
                ),
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown.shade500,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () async {
                        print("_selectedJob : $_selectedJob");
                        // Change Firestore /  "preferred_filters" > /uid > "selected_jobs" > array
                        // Clear
                        await FirebaseFirestore.instance
                          .collection("preferred_filters")
                          .doc(authState.currentUser?.uid)
                          .update({
                            'selected_jobs': FieldValue.delete()
                          })
                          .whenComplete(() => print("Field Deleted"));
                        
                        await FirebaseFirestore.instance
                          .collection("preferred_filters")
                          .doc(authState.currentUser?.uid)
                          .update({
                            'selected_jobs': _selectedJob
                          });
                        
                        context.goNamed("CondScreen");

                      },
                      child: const Text("決定する")),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
