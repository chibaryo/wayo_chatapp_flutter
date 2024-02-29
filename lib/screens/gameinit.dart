import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class GameInitScreen extends HookConsumerWidget {
  const GameInitScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    useEffect((){
    }, const []);

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              height: 240,
              child: Text("Love"),
            ),
            Text('GameInitScreen', style: TextStyle(fontSize: 32.0),),
          ],
        )),
    );
  }
}