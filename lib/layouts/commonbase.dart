import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wayo_chatapp/layouts/appbar_header.dart';
import 'package:wayo_chatapp/layouts/bottom_footer.dart';
import 'package:wayo_chatapp/layouts/sidenav/navcontents.dart';
import 'package:wayo_chatapp/providers/bottomnav/bottomnav_provider.dart';
import 'package:wayo_chatapp/screens/homescreen.dart';

class CommonBaseLayout extends HookConsumerWidget implements PreferredSizeWidget {
  const CommonBaseLayout({required this.body, Key? key}): super(key: key);
  final Widget body;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int selectIndex = ref.watch(bottomNavNotifierProvider);

    const List<Widget> _widgetOptions = <Widget>[
      HomeScreen(),
    ];

    return Scaffold(
      appBar: const AppbarHeader(),
      drawer: const NavContents(),
      body: Center(
        child: _widgetOptions.elementAt(selectIndex), //Text(selectIndex.toString()),
      ),
      bottomNavigationBar: const BottomNavFooter()
    );
  }
  
}
