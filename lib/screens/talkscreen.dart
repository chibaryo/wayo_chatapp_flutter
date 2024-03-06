import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_text_form_field_plus/custom_text_form_field_plus.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:wayo_chatapp/models/message.dart';
import 'package:wayo_chatapp/providers/firestore/message/message_provider.dart';

import '../models/user.dart';
import '../providers/firebase/auth/auth_provider.dart';
import '../providers/firestore/user/user_provider.dart';
import 'imagedetailscreen.dart';

class TalkScreen extends HookConsumerWidget {
  final String uid;
  const TalkScreen({Key? key, required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(firebaseAuthProvider);
//    final targetUid = ref.watch(currentFirebaseUserIdNotifierProvider);
    final _target = ref.watch(talkTargetUserStreamProvider(uid));
    final messageController = useTextEditingController();
    final conversationRecords = ref.watch(conversationStreamProvider(uid));
    final targetUid = useState("");

    useEffect((){
      print("_target.asData?.value: ${_target.asData?.value}");
      print("passed uid: $uid");
    }, const []);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: _target.when(
              data: (targetUser) {
                targetUid.value = targetUser[0].uid;

                return Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage(targetUser[0].imagepath),
                    ),
                    const SizedBox(width: 10.0),
                    Column(
                      children: <Widget>[
                        Text(targetUser[0].name, style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ))
                      ],
                    )
                  ]
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) {
                return Center(child: Text('Error: $error'));
              }
            ),
        backgroundColor: Colors.grey.shade100,
        actions: [
          IconButton(
            onPressed: () async {},
            icon: const Icon(Icons.logout),
          ),
        ],
        ),
      body: Column(
        children: <Widget>[
          // Talks ListView
          Expanded(
          child: conversationRecords.when(
            data: (conversation) {
              conversation.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
              return ListView.builder(

                itemCount: conversation.length,
                itemBuilder: (BuildContext context, int index) {
                  final isMe = authState.currentUser?.uid == conversation[index].senderUid;
                  final isImage = conversation[index].messageType == MessageType.image;

                  return isMe ? Slidable(
                    endActionPane: ActionPane(
                      extentRatio: 0.2,
                      motion: const BehindMotion(),
                      children: [
                        SlidableAction(
                          backgroundColor: Colors.red,
                          icon: Icons.delete,
                          label: '削除',
                          onPressed: (context) async {
                            await ref.read(asyncMessageNotifierProvider.notifier).deleteMessage(
                              messageId: conversation[index].messageId,
                              senderUid: conversation[index].senderUid,
                              messageType: conversation[index].messageType,
                              content: conversation[index].content
                            );
                          //  _onDeleteRow(context, index, jobs[index].job);
                          },
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Align(
                        alignment: isMe ? Alignment.topRight : Alignment.topLeft,
                        child: Container(
                          decoration: BoxDecoration(
                            color: isMe ? Colors.grey : Colors.pink.shade200,
                            borderRadius: isMe
                            ? const BorderRadius.only(
                                topRight: Radius.circular(30.0),
                                bottomLeft: Radius.circular(30.0),
                                topLeft: Radius.circular(30.0),
                              )
                            : const BorderRadius.only(
                                topRight: Radius.circular(30.0),
                                bottomRight: Radius.circular(30.0),
                                topLeft: Radius.circular(30.0),
                              )
                          ),
                          margin: const EdgeInsets.only(
                            top: 10,
                            right: 10,
                            left: 10,
                          ),
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                            children: <Widget>[
                              isImage
                                ?
                                  GestureDetector(
                                    onTap: () {
                                      context.pushNamed(
                                        "ImageDetailScreen",
                                        pathParameters: {
                                          "uid": authState.currentUser!.uid,
                                          "imagepath": conversation[index].content
                                        }
                                      );
                                    },
                                    child: Container(
                                      height: 200,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15.0),
                                        image: DecorationImage(
                                          image: NetworkImage(conversation[index].content),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  )
                                :
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                      conversation[index].content,
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                    const SizedBox(height: 5.0,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(timeago.format(conversation[index].createdAt!, locale: "ja")),
                                      ],
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  :
                  Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Align(
                        alignment: isMe ? Alignment.topRight : Alignment.topLeft,
                        child: Container(
                          decoration: BoxDecoration(
                            color: isMe ? Colors.grey : Colors.pink.shade200,
                            borderRadius: isMe
                            ? const BorderRadius.only(
                                topRight: Radius.circular(30.0),
                                bottomLeft: Radius.circular(30.0),
                                topLeft: Radius.circular(30.0),
                              )
                            : const BorderRadius.only(
                                topRight: Radius.circular(30.0),
                                bottomRight: Radius.circular(30.0),
                                topLeft: Radius.circular(30.0),
                              )
                          ),
                          margin: const EdgeInsets.only(
                            top: 10,
                            right: 10,
                            left: 10,
                          ),
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                            children: <Widget>[
                              isImage
                                ?
                                  GestureDetector(
                                    onTap: () {
                                      context.pushNamed(
                                        "ImageDetailScreen",
                                        pathParameters: {
                                          "uid": authState.currentUser!.uid,
                                          "imagepath": conversation[index].content
                                        }
                                      );
                                    },
                                    child: Container(
                                      height: 200,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15.0),
                                        image: DecorationImage(
                                          image: NetworkImage(conversation[index].content),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  )
                                :
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                      conversation[index].content,
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                    const SizedBox(height: 5.0,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(timeago.format(conversation[index].createdAt!, locale: "ja")),
                                      ],
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                }
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) {
              return Expanded(child: Center(child: Text('Error: $error')));
            }
          ),
          ),
          // Input field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: CustomTextFormField(
                    controller: messageController,
                    hintText: "メッセージを送りましょう...",
                  ),
                ),
                const SizedBox(width: 5,),
                CircleAvatar(
                  backgroundColor: Colors.purple,
                  radius: 20,
                  child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white),
                      onPressed: () async {
                        var uuid = Uuid();
                        var newId = uuid.v4();
            
                        await ref.read(asyncMessageNotifierProvider.notifier).addMessage(
                          messageId: newId,
                          senderUid: authState.currentUser!.uid,
                          receiverUid: targetUid.value,
                          content: messageController.text,
                          messageType: MessageType.text,
                        );
                        // Clear message input form
                        messageController.text = "";
                      },
                    ),
                ),
                const SizedBox(width: 5,),
                CircleAvatar(
                  backgroundColor: Colors.purple,
                  radius: 20,
                  child: IconButton(
                      icon: const Icon(Icons.camera_alt, color: Colors.white),
                      onPressed: () async {
                        ImagePicker imagePicker = ImagePicker();
                        XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
                        String filename = File(file!.path).uri.pathSegments.last;
                        print("${filename}");
                  
                        if (file == null) return;
                        // Import dart:core
                        String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
                  
                        // Get a reference to storage root
                        Reference referenceRoot = FirebaseStorage.instance.ref();
                        Reference referenceDirImages = referenceRoot.child('images');
                  
                        // Create a ref for the image to be stored
                        Reference referenceImageToUpload = referenceDirImages.child(filename);
                  
                        try {
                          // Store the file to CloudStorage
                          await referenceImageToUpload.putFile(File(file!.path));
                          // Success get the download URL
                          final gcsImagePath = await referenceImageToUpload.getDownloadURL();

                          // Image Message send
                          var uuid = Uuid();
                          var newId = uuid.v4();
                          await ref.read(asyncMessageNotifierProvider.notifier).addMessage(
                            messageId: newId,
                            senderUid: authState.currentUser!.uid,
                            receiverUid: targetUid.value,
                            content: gcsImagePath,
                            messageType: MessageType.image,
                          );

                        } catch (err) {
                          print(err);
                        }

                      },
                    ),
                ),
              ],
            ),
          ),
        ],
      ),
/*      Row(
        children: <Widget>[
                    _target.when(
            data: (targetUser) {
              return Text(targetUser.toString());
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) =>
              Center(child: Text('Error: $error')),
          ),

        ],
      ), */
    );
  }
}