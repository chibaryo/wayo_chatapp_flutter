import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wayo_chatapp/layouts/commonbase.dart';
import 'package:wayo_chatapp/providers/firestore/user/user_provider.dart';
import 'package:wayo_chatapp/screens/admin/selection_admin.dart';
import 'package:wayo_chatapp/screens/homescreen.dart';
import 'package:wayo_chatapp/screens/imagedetailscreen.dart';
import 'package:wayo_chatapp/screens/rootscreen.dart';

import '../screens/admin/job_admin.dart';
import '../screens/admin/user_admin.dart';
import '../screens/chats.dart';
import '../screens/cond_screen.dart';
import '../screens/gameinit.dart';
import '../screens/jobselection_screen.dart';
import '../screens/loginscreen.dart';
import '../screens/marriedselection_screen.dart';
import '../screens/registeruser.dart';
import '../screens/talkscreen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(initialLocation: "/", routes: <RouteBase>[
    ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget body) =>
          CommonBaseLayout(body: body),
      routes: <RouteBase>[
        GoRoute(
          path: "/home",
          name: "HomeScreen",
          builder: (BuildContext context, GoRouterState state) =>
              const HomeScreen(),
        ),
      ],
    ),
    GoRoute(
      path: "/admin/selection",
      name: "SelectionAdminScreen",
      builder: (BuildContext context, GoRouterState state) =>
          const SelectionAdminScreen(),
    ),
    GoRoute(
      path: "/",
      name: "RootScreen",
      builder: (BuildContext context, GoRouterState state) =>
          const RootScreen(),
    ),
    GoRoute(
      path: "/admin/user",
      name: "UserAdminScreen",
      builder: (BuildContext context, GoRouterState state) =>
          const UserAdminScreen(),
    ),
    GoRoute(
      path: "/admin/job",
      name: "JobAdminScreen",
      builder: (BuildContext context, GoRouterState state) =>
          const JobAdminScreen(),
    ),
    GoRoute(
      path: "/gameinit",
      name: "GameInitScreen",
      builder: (BuildContext context, GoRouterState state) =>
          const GameInitScreen(),
    ),
    GoRoute(
      path: "/registeruser",
      name: "RegisterUserScreen",
      builder: (BuildContext context, GoRouterState state) =>
          const RegisterUserScreen(),
    ),
    GoRoute(
      path: "/chats",
      name: "ChatsScreen",
      builder: (BuildContext context, GoRouterState state) =>
          const ChatsScreen(),
    ),
    GoRoute(
      path: "/login",
      name: "LoginScreen",
      builder: (BuildContext context, GoRouterState state) =>
          const LoginScreen(),
    ),
    GoRoute(
      path: "/talk/:uid",
      name: "TalkScreen",
      builder: (BuildContext context, GoRouterState state) {
        return TalkScreen(uid: state.pathParameters["uid"]!);
      },
      routes: [
        GoRoute(
          path: "imagedetail/:imagepath",
          name: "ImageDetailScreen",
          builder: (BuildContext context, GoRouterState state) {
            return ImageDetailScreen(
              uid: state.pathParameters["uid"]!,
              imagepath: state.pathParameters["imagepath"]!
            );
          }
        ),
      ]
    ),
    //
    GoRoute(
      path: "/condition",
      name: "CondScreen",
      builder: (BuildContext context, GoRouterState state) =>
          const CondScreen(),
    ),
    // MarriedSelection
    GoRoute(
      path: "/selection/married",
      name: "MarriedSelection",
      builder: (BuildContext context, GoRouterState state) =>
          const MarriedSelection(),
    ),
    //JobSelection
    GoRoute(
      path: "/selection/job",
      name: "JobSelection",
      builder: (BuildContext context, GoRouterState state) =>
          const JobSelection(),
    ),
  ]);
});
