import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    useEffect((){
    }, const []);

    return const Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('ホーム画面', style: TextStyle(fontSize: 32.0),),
          ],
        )),
    );
  }
}