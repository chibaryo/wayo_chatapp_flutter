import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/firebase/auth/auth_provider.dart';

class NavContents extends HookConsumerWidget {
  const NavContents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(firebaseAuthProvider);

    return Drawer(
      child: ListView(
            padding: EdgeInsets.zero,
            children: [
/*              UserAccountsDrawerHeader(
                accountName:  Text(user.displayName!),
                accountEmail:  Text(user.email!),
                currentAccountPicture: CircleAvatar(
                  child: ClipOval(
                    child: Image.asset('images/20240208_asagei_mihara.jpg'), //Image.network(user.photoURL!),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.deepPurpleAccent,
//                  image: DecorationImage(image: AssetImage('images/600011.jpeg'), fit: BoxFit.cover)
                ),
              ), */
              ListTile(
                leading: const Icon(Icons.notifications),
                title: const Text("通知"),
                onTap: () => context.goNamed("PushAdminScreen"),
              ),
              ListTile(
                leading: const Icon(Icons.analytics_outlined),
                title: const Text("統計"),
                onTap: () => print('Upload tapped'),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.person_2),
                title: const Text("ユーザ管理"),
                onTap: () => context.goNamed("UserAdminScreen"),
              ),
              ListTile(
                leading: const Icon(Icons.tag),
                title: const Text("タグ管理"),
                onTap: () => context.goNamed("TagAdminScreen"),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text("設定"),
                onTap: () => print('Upload tapped'),
              ),
              authState.currentUser?.uid != null
              ?
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text("サインアウト"),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                },
              )
              :
              ListTile(
                leading: const Icon(Icons.login),
                title: const Text("サインイン"),
                onTap: () async {
//                  await FirebaseAuth.instance.si();
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.gamepad),
                title: const Text("init"),
                onTap: () => context.goNamed("GameInitScreen"),
              ),
              ListTile(
                leading: const Icon(Icons.chat_bubble),
                title: const Text("Chats"),
                onTap: () => context.goNamed("ChatsScreen"),
              ),
            ],
          ),
    );
  }
}
