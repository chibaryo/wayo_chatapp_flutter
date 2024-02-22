import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wayo_chatapp/layouts/commonbase.dart';
import 'package:wayo_chatapp/screens/admin/selection_admin.dart';
import 'package:wayo_chatapp/screens/homescreen.dart';
import 'package:wayo_chatapp/screens/rootscreen.dart';

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
    )
  ]);
});
