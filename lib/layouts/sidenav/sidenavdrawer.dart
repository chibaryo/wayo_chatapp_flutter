import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wayo_chatapp/layouts/sidenav/navcontents.dart';

class SideNavDrawer extends HookConsumerWidget {
  const SideNavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
  
    return Scaffold(
      appBar: AppBar(
        title: const Text("Navigation drawer"),
        backgroundColor: Colors.teal,
      ),
      drawer: const NavContents(),
      body: Center(
        child: Column(
          children: [
            const Text("main page", style: TextStyle(fontSize: 40.0),),
            ElevatedButton(
              onPressed: () {
                context.go("/login");
              },
              child: const Text(" goto /login"),
            ),
          ],
        ),
      ),
    );
  }
}