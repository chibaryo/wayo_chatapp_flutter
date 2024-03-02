import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:logger/logger.dart';

import '../models/user.dart';
import '../providers/firebase/auth/auth_provider.dart';
import '../providers/firestore/user/user_provider.dart';

class TalkScreen extends HookConsumerWidget {
  final String uid;
  const TalkScreen({Key? key, required this.uid}) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(firebaseAuthProvider);
//    final targetUid = ref.watch(currentFirebaseUserIdNotifierProvider);
    final _target = ref.watch(talkTargetUserStreamProvider(uid));

    useEffect((){
      print(_target.asData?.value);
    }, const []);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: _target.when(
              data: (targetUser) {
                return Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage(targetUser[0].imagepath),
                    ),
                    const SizedBox(width: 10.0),
                    Column(
                      children: <Widget>[
                        Text(targetUser[0].name, style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ))
                      ],
                    )
                  ]
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) =>
                Center(child: Text('Error: $error')),
            ),
        backgroundColor: Colors.grey.shade100,
        actions: [
          IconButton(
            onPressed: () async {},
            icon: const Icon(Icons.logout),
          ),
        ],
        ),
      body: Center(
        child: Column(
          children: [
            _target.when(
              data: (targetUser) {
                return Text(targetUser.toString());
              },
              loading: () => Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) =>
                Center(child: Text('Error: $error')),
            ),
            const Text('Talk', style: TextStyle(fontSize: 32.0),),
          ],
        )),
    );
  }
}