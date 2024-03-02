import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_admin/firebase_admin.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:logger/logger.dart';
import 'package:file_picker/file_picker.dart';
import 'package:wayo_chatapp/providers/firestore/selection/middocid_provider.dart';
import 'package:wayo_chatapp/providers/firestore/selection/parentdocid_provider.dart';

import '../../layouts/sidenav/navcontents.dart';
import '../../models/selection.dart';
import '../../pageparts/adduserpopup.dart';
import '../../providers/dropdown/dropdownchildselection_provider.dart';
import '../../providers/firebase/admin/firebaseadmin_provider.dart'
    as adminProvider;
import '../../providers/firebase/auth/auth_provider.dart';
import '../../providers/firestore/selection/selection_provider.dart';
import '../../providers/form/formparts_provider.dart';

final logger = Logger();

class UserAdminScreen extends HookConsumerWidget {
  const UserAdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final _selectionList = ref.watch(selectionStreamProvider);
    final _midSelectionList = ref.watch(childLimiSelectionStreamProvider);
    final _name = ref.watch(formNameNotifierProvider);
    final _nameController = useTextEditingController(text: _name);

    useEffect(() {}, const []);

    Future openDialog() => showDialog(
      context: context,
      builder: (context) => AddUserPopup(),
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("ユーザ管理"),
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
                onPressed: () {
                  openDialog();
                },
                child: const Text("ユーザ追加")),
          ),
          ElevatedButton(
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.currentUser?.updateDisplayName("笹岡ゆうこ");
                  } catch (err) {
                    throw Exception(err);
                  }
                },
                child: const Text("photoURL")
          ),
        ],
      )),
    );
  }
}
