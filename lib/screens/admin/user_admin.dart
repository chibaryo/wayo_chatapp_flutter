import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:excel/excel.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_admin/firebase_admin.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:logger/logger.dart';
import 'package:file_picker/file_picker.dart';

import '../../layouts/sidenav/navcontents.dart';
import '../../pageparts/adduserpopup.dart';
import '../../providers/firebase/auth/auth_provider.dart';
import '../../providers/form/formparts_provider.dart';

final logger = Logger();

class UserAdminScreen extends HookConsumerWidget {
  const UserAdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(firebaseAuthProvider);
    final _name = ref.watch(formNameNotifierProvider);
    final _nameController = useTextEditingController(text: _name);
    final isObscurePassword = useState(true);

    useEffect(() {
      print("photoURL: ${authState.currentUser?.photoURL}");
    }, const []);

    Future openDialog() => showDialog(
      context: context,
      builder: (context) => AddUserPopup(),
    );

  Widget buildTextField(String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextField(
        obscureText: isPasswordTextField ? true : false,
        decoration: InputDecoration(
          suffixIcon: isPasswordTextField ?
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.remove_red_eye, color: Colors.grey,),
          ) :null,
          contentPadding: EdgeInsets.only(bottom: 5),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey)
        ),
      ),
    );
  }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("ユーザ管理"),
        backgroundColor: Colors.lime,
        actions: [
          IconButton(
            onPressed: () async {

            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      drawer: const NavContents(),
      body: Container(
        padding: EdgeInsets.only(left: 15, top:20, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                      authState.currentUser?.photoURL != null
                      ?
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        border: Border.all(width: 4, color: Colors.white),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1)
                          )
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(authState.currentUser!.photoURL!),
                        )
                      ),
                    )
                      :
                      const CircleAvatar(
                        backgroundColor: Color(0xffE6E6E6),
                        radius: 100,
                        child: Icon(
                          Icons.person,
                          color: Colors.grey,
                        ),
                      ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          // Launch image-picker

                          // CloudStorage: Delete old image, upload new image

                          // Change Firestore "users" imagepath

                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Colors.white,
                            ),
                            color: Colors.blue,
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30,),
              buildTextField("氏名", authState.currentUser!.displayName!, false),
              buildTextField("メールアドレス", authState.currentUser!.email!, false),
              buildTextField("パスワード", "**************", true),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: Text("キャンセル", style: TextStyle(fontSize: 15, letterSpacing: 2, color: Colors.black)),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("保存", style: TextStyle(fontSize: 15, letterSpacing: 2, color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ],
              )

            ],
          ),
        ),
      ),

    );
  }
}
