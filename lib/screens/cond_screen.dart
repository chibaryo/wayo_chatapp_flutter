import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:logger/logger.dart';

import '../providers/cond_selections/cond_selections_provider.dart';
import '../providers/firebase/auth/auth_provider.dart';
import '../providers/firestore/user/selectedjob_provider.dart';

final logger = Logger();

class CondScreen extends HookConsumerWidget {
  const CondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _selectedJob = ref.watch(selectedJobNotifierProvider);
    final _selectedMarriedStatus = ref.watch(condSelectionIsMarriedNotifierProvider);
    final authState = ref.watch(firebaseAuthProvider);

    useEffect(() {
      print("marr sta: ${_selectedMarriedStatus.toString()}");

    }, const []);
    final List<int> _numList = List.generate(100, (index) => index);
    final _scrollController = useScrollController();

    final List<Map<String, dynamic>> _tileItems = [
      {
        "label": "年齢",
        "link": "AgeSelection()",
        "value": "こだわらない",
      },
      {
        "label": "居住地",
        "link": "PrefSelection()",
        "value": "こだわらない",
      },
      {
        "label": "年収",
        "link": "SalarySelection()",
        "value": "こだわらない",
      },
      {
        "label": "身長",
        "link": "HeightSelection()",
        "value": "こだわらない",
      },
      {
        "label": "体型",
        "link": "BodyStyleSelection()",
        "value": "こだわらない",
      },
      {
        "label": "職業",
        "link": "JobSelection",
        "value": _selectedJob.isNotEmpty ? _selectedJob.join(", ") : "こだわらない",
      },
      {
        "label": "結婚歴",
        "link": "MarriedSelection",
        "value": _selectedMarriedStatus.isNotEmpty ? _selectedMarriedStatus.join(", ") : "こだわらない",
      },
      {
        "label": "子どもの有無",
        "link": "HaveChildSelection()",
        "value": "こだわらない",
      },
      {
        "label": "マッチングしたら",
        "link": "AfterMathingSelection()",
        "value": "こだわらない",
      },
      {
        "label": "休日",
        "link": "HolidaySelection()",
        "value": "こだわらない",
      },
      {
        "label": "お酒",
        "link": "AlcoholSelection()",
        "value": "こだわらない",
      },
      {
        "label": "たばこ",
        "link": "SmokingSelection()",
        "value": "こだわらない",
      },
      {
        "label": "自己PRあり",
        "link": "HaveSelfPRSelection()",
        "value": "こだわらない",
      },
      {
        "label": "プロフ写真あり",
        "link": "HaveProfilePicsSelection()",
        "value": "こだわらない",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("絞り込み条件設定"),
        backgroundColor: Colors.grey.shade100,
        actions: [
          IconButton(
            onPressed: () async {},
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: _tileItems.length,
            itemBuilder:  (context, index) =>
              GestureDetector(
                onTap: () {
                  context.pushNamed(_tileItems[index]["link"]);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(
                        _tileItems[index]["label"],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                    ),
                    // *** Attention ! overflow ***
                    Text(
                      _tileItems[index]["value"],
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                    ),
                    // *** Attention ! overflow ***
                  ],
                ),
              ),
            ),
            // Button Area
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
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
                      onPressed: () {
                        context.goNamed("ChatsScreen");
                      },
                      child: const Text("決定する")
                    ),
                  ),
                ],
              ),
            ),
            // End Button Area
        ],
      ),
      /*          ListView.builder(
        itemCount: _tileItems.length,
        itemBuilder:  (context, index) =>
         GestureDetector(
          onTap: () {
      
          },
          child: Row(
            children: [
              Expanded(
                child: Text("Foo"), //Text(_tileItems[index]["label"], style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),),
              ),
      /*                  Expanded(
                child: Text(_tileItems[index]["value"], style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300)),
              ), */
            ],
          ),
        )
      /*              child
          Container(Text(_tileItems[index]["label"], style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),),
          onTap: () {
            context.pushNamed(_tileItems[index]["link"]);
          },
          trailing: 
            Wrap(
              spacing: 8.0,
              direction: Axis.horizontal,
              children: <Widget>[
                Text(_tileItems[index]["value"], style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300)),
                const Icon(Icons.keyboard_arrow_right_sharp),
              ],
            ),
        ), */
      ),*/
    );
  }
}
