import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:logger/logger.dart';
import 'package:wayo_chatapp/platform/web/webroot.dart';
import 'package:wayo_chatapp/providers/fcm/token_provider.dart';

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
        body: Center(
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
                  child: const Text("選択肢管理")),
              ElevatedButton(
                  onPressed: () async {
                    final serverdate = DateTime.now(); //.toLocal().toIso8601String();

                    final fcmToken = await initFCM();
                    if (fcmToken != "") {
                      // Store fcmToken to Provider
                      print("save fcmToken to provider...");
                      ref.read(fcmTokenNotifierProvider.notifier).state = fcmToken;
                    }
                    // Register as anonymous user
                    try {
                      final FirebaseAuth auth = FirebaseAuth.instance;
                      final UserCredential result = await auth.signInAnonymously();
                      print("Anon-user uid: ${result.user?.uid}");
                      // Save fcmToken to Firestore
                      await FirebaseFirestore.instance
                        .collection("unregistered_users")
                        .doc(result.user?.uid)
                        .set({
                          "fcmToken": fcmToken,
                          "createdAt": serverdate,
                        });

                    } catch (err) {
                      print("error: $err");
                    }
                    // Listen (Foreground)
                    FirebaseMessaging.onMessage
                        .listen((RemoteMessage message) async {
                      print("Got a message whilst in the foreground!");
                      print("message.data: ${message.data}");
                      inspect(message?.notification);
                    });
                  },
                  child: const Text("通知許可")),
            ],
          ),
        ));
  }
}
