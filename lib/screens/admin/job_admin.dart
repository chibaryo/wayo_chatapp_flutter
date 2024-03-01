import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_admin/firebase_admin.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:logger/logger.dart';
import 'package:file_picker/file_picker.dart';
import 'package:wayo_chatapp/providers/firestore/job/job_provider.dart';
import 'package:wayo_chatapp/providers/firestore/selection/middocid_provider.dart';
import 'package:wayo_chatapp/providers/firestore/selection/parentdocid_provider.dart';
import 'package:wayo_chatapp/providers/form/jobtype_provider.dart';

import '../../layouts/sidenav/navcontents.dart';
import '../../models/selection.dart';
import '../../pageparts/addjobpopup.dart';
import '../../pageparts/adduserpopup.dart';
import '../../providers/dropdown/dropdownchildselection_provider.dart';
import '../../providers/firebase/admin/firebaseadmin_provider.dart'
    as adminProvider;
import '../../providers/firebase/auth/auth_provider.dart';
import '../../providers/firestore/selection/selection_provider.dart';
import '../../providers/form/formparts_provider.dart';

final logger = Logger();

class JobAdminScreen extends HookConsumerWidget {
  const JobAdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final _jobs = ref.watch(asyncFirebaseJobNotifierProvider);
    final _id = ref.watch(formJobDocIdNotifierProvider);

    final _screenWidth = MediaQuery.of(context).size.width;
    final _startAnimation = useState(false);
    final scrollController = useScrollController();

    useEffect(() {
      _startAnimation.value = true;
    }, const []);

    Future openDialog() => showDialog(
      context: context,
      builder: (context) => AddJobPopup(),
    );

    Future _onDeleteRow (BuildContext context, int index, String job) async {
      print("index : $index");
      print("job: $job");
      await ref.read(asyncFirebaseJobNotifierProvider.notifier).removeFirebaseJob(
        job: job
      );
    }
    Future _onEditRow (
      BuildContext context,
      int index,
      String docId,
      String job,
      String label,
      String jobGenre) async {
      // Show popup
      ref.read(formJobNameNotifierProvider.notifier).state = job;
      ref.read(formLabelNameNotifierProvider.notifier).state = label;
      ref.read(formJobGenreNameNotifierProvider.notifier).state = jobGenre;
      ref.read(formJobPopupModalModeNotifierProvider.notifier).state = "edit";
      ref.read(formJobDocIdNotifierProvider.notifier).state = docId;

      print("job: $job, label: $label, jobGenre: $jobGenre");
      print("job.watch : ${ref.watch(formJobNameNotifierProvider)}");
      print("label.watch : ${ref.watch(formLabelNameNotifierProvider)}");
      print("jobGenre.watch : ${ref.watch(formJobGenreNameNotifierProvider)}");
      print(ref.watch(formJobPopupModalModeNotifierProvider));

      await openDialog();
    }

    void _onDismissed () {
//      print()
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("ジョブ管理"),
        backgroundColor: Colors.lime,
        actions: [
          IconButton(
            onPressed: () async {

            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      drawer: const NavContents(),
      body: Center(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  authState.when(
                    data: (auth) {
                      return Text("ログインUID: ${auth?.uid}");
                    },
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (error, stackTrace) => Center(child: Text('Error: $error'))
                  )
                ],
              ),
            ),
          ),
          Container(
            child: ElevatedButton(
                onPressed: () async {
                  ref.read(formJobPopupModalModeNotifierProvider.notifier).state = "add";
                  print(ref.watch(formJobPopupModalModeNotifierProvider));
                  await openDialog();
                },
                child: const Text("ジョブ追加")),
          ),
          Expanded(
            child: _jobs.when(
              data: (jobs) {
                return ListView.builder(
                  controller: scrollController,
                  itemCount: jobs.length,
                  itemBuilder: (context, index) {
                    return AnimatedContainer(
                      width: _screenWidth,
                      curve: Curves.easeInOut,
                      duration: Duration(milliseconds: 300 + (index * 3)),
                      transform: Matrix4.translationValues(_startAnimation.value ? 0 : _screenWidth, 0, 0),
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: EdgeInsets.symmetric(
                        horizontal: _screenWidth / 20,
                      ),
                      child: Slidable(
                        startActionPane: ActionPane(
                          extentRatio: 0.2,
                          motion: const StretchMotion(),
                          children: [
                            SlidableAction(
                              backgroundColor: Colors.green,
                              icon: Icons.share,
                              label: '共有',
                              onPressed: (context) => print(scrollController.offset), //_onDismissed(),
                            ),
                            SlidableAction(
                              backgroundColor: Colors.blue,
                              icon: Icons.edit,
                              label: '編集',
                              onPressed: (context) => _onEditRow(
                                context,
                                index,
                                jobs[index].id,
                                jobs[index].job,
                                jobs[index].label,
                                jobs[index].jobGenre,
                              ),
                            ),
                          ],
                        ),
                        endActionPane: ActionPane(
                          extentRatio: 0.2,
                          motion: const BehindMotion(),
                          children: [
                            SlidableAction(
                              backgroundColor: Colors.red,
                              icon: Icons.delete,
                              label: '削除',
                              onPressed: (context) async {
                                _onDeleteRow(context, index, jobs[index].job);
                              },
                            )
                          ],
                        ),
                        child: ListTile(
                          tileColor: Colors.lightBlue.shade200,
                          contentPadding: EdgeInsets.only(left: 24.0),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0),
                            )
                          ),
                          title: Center(child: Text("${jobs[index].label}")),
                          subtitle: Center(child: Text("${jobs[index].job}")),
                        ),
                      ),
                    );
                  }
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(child: Text('Error: $error'))
            ),
          )
        ],
      )),
    );
  }
}
