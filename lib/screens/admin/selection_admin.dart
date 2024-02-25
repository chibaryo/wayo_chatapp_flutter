import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:logger/logger.dart';
import 'package:file_picker/file_picker.dart';
import 'package:wayo_chatapp/providers/firestore/selection/middocid_provider.dart';
import 'package:wayo_chatapp/providers/firestore/selection/parentdocid_provider.dart';

import '../../models/selection.dart';
import '../../providers/dropdown/dropdownchildselection_provider.dart';
import '../../providers/firestore/selection/selection_provider.dart';

final logger = Logger();

class SelectionAdminScreen extends HookConsumerWidget {
  const SelectionAdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _selectionList = ref.watch(selectionStreamProvider);
    final _midSelectionList = ref.watch(childLimiSelectionStreamProvider);

    useEffect(() {
//      ref.read(parentDocIdNotifierProvider.notifier).state = "";
    }, const []);

    return Scaffold(
      body: Center(
          child: Column(
        children: [
          const Text(
            '選択肢管理',
            style: TextStyle(fontSize: 32.0),
          ),
          Container(
            child: ElevatedButton(
              child: const Text("Boo"),
              onPressed: () async {
                FilePickerResult? picResult =
                    await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ["xlsx"],
                  withData: true,
                );

                if (picResult != null) {
                  PlatformFile file = picResult!.files.first;
                  var excel = Excel.decodeBytes(file.bytes as Uint8List);

                  if (excel.tables.isNotEmpty) {
                    print("空ではない!");
                    var table = excel.tables[excel.tables.keys.first];

                    for (var row in table!.rows) {
                      var itemId = row[0]?.value;
                      var text = row[1]?.value;
                      print("itemId: $itemId, text: $text");
                    }
                  }
                } else {
                  // User canceled the picker
                }
              },
            ),
          ),
          Container(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("selections")
                  .snapshots(),
              builder: (context, snapshot) {
                List<DropdownMenuItem> selItems = [];
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                } else {
                  final sels = snapshot.data?.docs.reversed.toList();
                  // Add default
                  selItems.add(const DropdownMenuItem(
                    value: "0",
                    child: Text("Please select..."),
                  ));

                  for (var sel in sels!) {
                    selItems.add(
                      DropdownMenuItem(
                        value: sel.id,
                        child: Text(sel["text"]),
                      ),
                    );
                  }
                }
                return DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    items: selItems,
                    onChanged: (newValue) {
                      ref.read(midDocIdNotifierProvider.notifier).state = "0";
                      ref.read(parentDocIdNotifierProvider.notifier).state =
                          newValue;
                    },
                    value: ref.watch(parentDocIdNotifierProvider),
                  ),
                );
              },
            ),
          ),
          Container(
            child:               ref.watch(parentDocIdNotifierProvider) != "0" ? StreamBuilder<QuerySnapshot>(
              stream: 
              FirebaseFirestore.instance
                .collection("child_selections")
                .where("parentId", isEqualTo: ref.watch(parentDocIdNotifierProvider))
                .snapshots(),
              builder: (context, snapshot) {
                List<DropdownMenuItem> midselItems = []; // Prepare empty array
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                else {
                  final midsels = snapshot.data?.docs.reversed.toList();
                  print("midsels: ${midsels.toString()}");
                  // Add default
                  midselItems.add(const DropdownMenuItem(
                    value: "0",
                    child: Text("Please select..."),
                  ));


                  for (var sel in midsels!) {
                    midselItems.add(DropdownMenuItem(
                      value: sel.id,
                      child: Text(
                        sel["text"]
                      ),
                    ),
                  );
                  }
                }
                return DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    items: midselItems,
                    onChanged: (newValue) {
                      ref.read(midDocIdNotifierProvider.notifier).state = newValue;
                    },
                    value: ref.watch(midDocIdNotifierProvider),
                  ),
                );
              },
            ) : null,
          ),
        ],
      )),
    );
  }
}
