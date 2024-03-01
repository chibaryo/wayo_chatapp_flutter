import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:logger/logger.dart';

import '../providers/cond_selections/cond_selections_provider.dart';
import '../providers/firebase/auth/auth_provider.dart';
import '../providers/firestore/user/selectedjob_provider.dart';
import '../providers/firestore/user/user_provider.dart';
import '../providers/form/formparts_provider.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _formKey =
        useMemoized(() => GlobalKey<FormState>()); //GlobalKey<FormState>();
    final _email = ref.watch(formEmailAddrNotifierProvider);
    final _password = ref.watch(formPasswordNotifierProvider);
    final _emailController = useTextEditingController(text: _email);
    final _passwordController = useTextEditingController(text: _password);

    final _selectedJob = ref.watch(selectedJobNotifierProvider);
    final _selectedMarriedStatus = ref.watch(condSelectionIsMarriedNotifierProvider);
    final authState = ref.watch(firebaseAuthProvider);

      // Get initial preferred jobs
      Future<List<String>> _getPreferredJobs () async {
        if (authState.currentUser?.uid != null) {
        final doc = await FirebaseFirestore.instance
          .collection('preferred_filters')
          .doc(authState.currentUser?.uid)
          .get();

        final List<dynamic> selectedJobsDynamic = doc["selected_jobs"];
        final List<String> selectedJobs = selectedJobsDynamic.map((job) => job.toString()).toList();

        print("selected_jobs : $selectedJobs");
        return selectedJobs;
        }
        else {
          return [];
        }
      }
      // Get initial preferred married_status
      Future<List<String>> _getPreferredMarriedStatus () async {
        if (authState.currentUser?.uid != null) {
        final doc = await FirebaseFirestore.instance
          .collection('preferred_filters')
          .doc(authState.currentUser?.uid)
          .get();

        final List<dynamic> selectedMarriedDynamic = doc["married_status"];
        final List<String> selectedMarried = selectedMarriedDynamic.map((el) => el.toString()).toList();

        return selectedMarried;
        }
        else {
          return [];
        }
      }

    useEffect(() {}, const []);

    return Scaffold(
      body: Center(
          child: Column(
        children: <Widget>[
          Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Text(
                  'Login',
                  style: TextStyle(fontSize: 32.0),
                ),
                TextFormField(
                  autofocus: true,
                  controller: _emailController,
                  decoration: const InputDecoration(hintText: "メールアドレス"),
                  onChanged: (text) {
                    ref.watch(formEmailAddrNotifierProvider.notifier).state =
                        text;
                  },
                ),
                TextFormField(
                  autofocus: true,
                  controller: _passwordController,
                  decoration: const InputDecoration(hintText: "パスワード"),
                  onChanged: (text) {
                    ref.watch(formPasswordNotifierProvider.notifier).state =
                        text;
                  },
                ),
                Container(
                  child: ElevatedButton(
                    child: const Text("ログイン"),
                    onPressed: () async {
                      final serverDate = DateTime.now();
                      final jobNotifier = ref.read(selectedJobNotifierProvider.notifier);
                      final marriedNotifier = ref.read(condSelectionIsMarriedNotifierProvider.notifier);

                      try {
                        await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                            email: _email,
                            password: _password,
                          );

                        // Set preset filters
                        _getPreferredJobs().then((value) {
                          print("value: $value");
                          for (var e in value) {
                            print("e:  $e");
                            jobNotifier.addJob(e);
                          }
                        });

                        _getPreferredMarriedStatus().then((value) {
                          print("value: $value");
                          for (var e in value) {
                            marriedNotifier.addSelection(e);
                          }
                        });
                        
                        // Goto chatpage
                        context.goNamed("ChatsScreen");
                      } catch (err) {
                        throw Exception(err);
                      }
                    },
                  ),
                ),
              ]))
        ],
      )),
    );
  }
}
