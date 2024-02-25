import 'dart:developer';
import 'dart:html' as web;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:wayo_chatapp/providers/fcm/token_provider.dart';

Future<String> initFCM() async {
    print("!!! We are in kIsWeb env !!!");
    final messaging = FirebaseMessaging.instance;
//    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      await messaging.deleteToken();
      final fcmToken = await messaging.getToken(vapidKey: "BMbxodZhFyE6xSuPhjVNphISLPtHOOUh7xQpA2Q6JPT20jz9RRuPMFiIYMV5frLY3YmiLKq9WG2OnQaPX43N14U");
      print("FCM Token: $fcmToken");

      return fcmToken!;

      // Save fcmToken to provider
//      ref.read(fcmTokenNotifierProvider.notifier).state = fcmToken;
    }
    return "";
}

//////////////
Future<void> showNotification(Map<String, dynamic>message) async {
  var permission = web.Notification.permission;
  if (permission != 'granted') {
    permission = await web.Notification.requestPermission();
  }
  
  if (permission == 'granted') {
    web.Notification(
      message["title"],
      body: message["body"],
//      image: message["image"],
    );
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print("Handling a background message: ${message.messageId}");
}