import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class RegisterUserScreen extends HookConsumerWidget {
  const RegisterUserScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    useEffect((){
    }, const []);

    return const Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('RegisterUserScreen', style: TextStyle(fontSize: 32.0),),
          ],
        )),
    );
  }
}