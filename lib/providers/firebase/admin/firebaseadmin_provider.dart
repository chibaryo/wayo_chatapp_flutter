import 'package:firebase_admin/firebase_admin.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Define firebaseAdminProvider
final firebaseAdminProvider = FutureProvider<App>((ref) async {
  var credential = Credentials.applicationDefault();
  credential ??= await Credentials.login();
  var projectId = "react-noti-app-5c9f4";
  return FirebaseAdmin.instance.initializeApp(AppOptions(
    credential: credential,
    projectId: projectId,
    storageBucket: '$projectId.appspot.com'
  ));
});