import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class RootScreen extends HookConsumerWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {}, const []);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Root"),
          backgroundColor: Colors.teal,
        ),
        body:  Center(
          child: Column(
            children: [
              const Text(
                'Root!',
                style: TextStyle(fontSize: 32.0),
              ),
            ElevatedButton(
              onPressed: () {
                context.push('/admin/selection');
              },
              child: const Text("選択肢管理")
            ),
            ],
          ),
        ));
  }
}
