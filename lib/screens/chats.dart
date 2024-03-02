import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_admin/firebase_admin.dart';
import 'package:flutter/foundation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:logger/logger.dart';
import 'package:file_picker/file_picker.dart';
import 'package:wayo_chatapp/models/jobtype.dart';
import 'package:wayo_chatapp/models/user.dart';
import 'package:wayo_chatapp/providers/firestore/selection/middocid_provider.dart';
import 'package:wayo_chatapp/providers/firestore/selection/parentdocid_provider.dart';
import 'package:wayo_chatapp/providers/firestore/user/selectedjob_provider.dart';

import '../../layouts/sidenav/navcontents.dart';
import '../../models/selection.dart';
import '../../providers/dropdown/dropdownchildselection_provider.dart';
import '../../providers/firebase/admin/firebaseadmin_provider.dart'
    as adminProvider;
import '../../providers/firestore/selection/selection_provider.dart';
import '../providers/cond_selections/cond_selections_provider.dart';
import '../providers/firebase/auth/auth_provider.dart';
import '../providers/firestore/job/job_provider.dart';
import '../providers/firestore/user/user_provider.dart';

final logger = Logger();

enum ViewType { grid, list }

class ChatsScreen extends HookConsumerWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _usersList = ref.watch(userStreamProvider);
    final _selectedJob = ref.watch(selectedJobNotifierProvider);
    final _selectedMarriedStatus = ref.watch(condSelectionIsMarriedNotifierProvider);
    final authState = ref.watch(firebaseAuthProvider);

    final _crossAxisCount = useState<int>(2);
    final _aspectratio = useState<double>(1.5);
    final _viewType = useState<ViewType>(ViewType.grid);
    final _jobLists = ref.watch(asyncFirebaseJobNotifierProvider);

/*    final _jobFilteredUsers = _usersList.asData?.value.where((user) {
      return _selectedJob.isEmpty || _selectedJob.contains(user.job);
    }).toList(); */

    final List<JobType> _job = [
      const JobType(job: "nurse", label: "看護師"),
      const JobType(job: "ol", label: "OL"),
      const JobType(job: "lawyer", label: "弁護士"),
      const JobType(job: "teacher", label: "先生"),
      const JobType(job: "tsutaya", label: "つたや"),
      const JobType(job: "wife", label: "主婦"),
      const JobType(job: "ca_not_lcc", label: "CA(LCC以外)"),
      const JobType(job: "publicist", label: "広報"),
    ];

    useEffect(() {
      // Get initial preferred jobs
      Future<List<String>> _getPreferredJobs () async {
        if (authState.currentUser?.uid != null) {
        final doc = await FirebaseFirestore.instance
          .collection('preferred_filters')
          .doc(authState.currentUser?.uid)
          .get();

        final List<dynamic> selectedJobsDynamic = doc["selected_jobs"];
        final List<String> selectedJobs = selectedJobsDynamic.map((job) => job.toString()).toList();

        print("selected_jobs : $selectedJobs");
        return selectedJobs;
        }
        else {
          return [];
        }
      }
      // Get initial preferred married_status
      Future<List<String>> _getPreferredMarriedStatus () async {
        if (authState.currentUser?.uid != null) {
        final doc = await FirebaseFirestore.instance
          .collection('preferred_filters')
          .doc(authState.currentUser?.uid)
          .get();

        final List<dynamic> selectedMarriedDynamic = doc["married_status"];
        final List<String> selectedMarried = selectedMarriedDynamic.map((el) => el.toString()).toList();

        return selectedMarried;
        }
        else {
          return [];
        }
      }

    }, const []);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Chats"),
        backgroundColor: Colors.lime,
        actions: [
          IconButton(
            onPressed: () {
              if ( _viewType.value == ViewType.list ) {
                _crossAxisCount.value = 2;
                _aspectratio.value = 1.5;
                _viewType.value = ViewType.grid;
                print("_viewType: ${_viewType.value}");
              } else {
                _crossAxisCount.value = 1;
                _aspectratio.value = 1.5;
                _viewType.value = ViewType.list;
                print("_viewType: ${_viewType.value}");
              }
            },
            icon: Icon(_viewType == ViewType.list ? Icons.grid_on : Icons.view_list)
          ),
        ],
      ),
      drawer: const NavContents(),
      body: Center(
          child: Column(
        children: [
          // Filter settings
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: InkWell(
              onTap: () {
                print("Tage");
                context.pushNamed("CondScreen");
              },
              child: Container(
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        child: FaIcon(FontAwesomeIcons.sliders),
                      ),
                      SizedBox(width: 10.0,),
                      Container(
                        child: _selectedJob.isNotEmpty || _selectedMarriedStatus.isNotEmpty
                        ? const Text("絞り込み中", style: TextStyle(color: Colors.brown),)
                        : const Text("絞り込み設定", style: TextStyle(color: Colors.brown),),
                      )
                    ],
                  ),
                ),
              )
            ),
          ),
          //
          // ListView
          Expanded(
            child: _usersList.when(
                data: (userData) {
                  final _jobFilteredUsers =
                      userData.where((user) {
                        return
                          (_selectedJob.isEmpty || _selectedJob.contains(user.job))
                          &&
                          (_selectedMarriedStatus.isEmpty || _selectedMarriedStatus.contains(user.married_status))
                        ;
                  }).toList();
                  final _marriedFilteredUsers = userData.where((user) {
                    return
                     (_selectedMarriedStatus.isEmpty || _selectedMarriedStatus.contains(user.married_status));
                  }).toList();

//                  final _resultArr

                  return _viewType.value == ViewType.list
                  ? ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _jobFilteredUsers.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => ListTile(
                      onTap: () async {
//                        print("_jobFilteredUsers[index]: ${_jobFilteredUsers[index]}");
                        context.pushNamed("TalkScreen", pathParameters: { "uid": _jobFilteredUsers[index].uid });
                      },
                      contentPadding: EdgeInsets.zero,
                      leading: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                NetworkImage(_jobFilteredUsers[index].imagepath),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: CircleAvatar(
                              backgroundColor: _jobFilteredUsers[index].isOnline
                                  ? Colors.green
                                  : Colors.grey,
                              radius: 5,
                            ),
                          )
                        ],
                      ),
                      title: Text(
                        _jobFilteredUsers[index].name,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Last Active: ${timeago.format(_jobFilteredUsers[index].lastActive!)}',
                        maxLines: 2,
                        style: const TextStyle(
                          color: Colors.purple,
                          fontSize: 15,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  )
                  : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: _crossAxisCount.value,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        itemCount: _jobFilteredUsers.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () async {
                              context.pushNamed("TalkScreen", pathParameters: { "uid": _jobFilteredUsers[index].uid });
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.network(
                                    _jobFilteredUsers[index].imagepath,
                                    fit: BoxFit.cover,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 28.0, bottom: 3.0),
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        _jobFilteredUsers[index].name,
                                        style: TextStyle(fontSize: 24, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 14,
                                    left: 8,
                                    child: CircleAvatar(
                                      backgroundColor: _jobFilteredUsers[index].isOnline
                                        ? Colors.green
                                        : Colors.grey,
                                      radius: 6,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      ),
                  );
                },
                loading: () => Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) =>
                    Center(child: Text('Error: $error'))),
          ),
        ],
      )),
    );
  }
}
