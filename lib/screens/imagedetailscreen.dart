import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class ImageDetailScreen extends HookConsumerWidget {
  final String imagepath;
  final String uid;
  const ImageDetailScreen({Key? key, required String this.uid, required String this.imagepath}) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    useEffect((){
    }, const []);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("画像詳細"),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ), 
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imagepath),
            fit: BoxFit.fitWidth,
          )
        ),
      ),
    );
  }
}