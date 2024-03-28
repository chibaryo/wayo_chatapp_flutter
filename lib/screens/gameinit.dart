import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:logger/logger.dart';

import '../../providers/firebase/auth/auth_provider.dart';

final logger = Logger();

class GameInitScreen extends HookConsumerWidget {
  const GameInitScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(firebaseAuthProvider);

    useEffect((){
    }, const []);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("テスト画面"),
        backgroundColor: Colors.lime,
        actions: [
          IconButton(
            onPressed: () async {
              authState.currentUser!.updatePhotoURL("https://livedoor.blogimg.jp/mediaworldakiba/imgs/e/d/ed734c52.jpg");
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            authState.currentUser != null
            ?
            Text(authState.currentUser.toString())
            :
            Text("gfoo"),
            Text('TestGameScreen', style: TextStyle(fontSize: 32.0),),
          ],
        )),
    );
  }
}