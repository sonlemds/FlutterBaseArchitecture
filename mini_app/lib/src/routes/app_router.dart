import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_app/src/presentation/home/home_page.dart';
import 'package:mini_app/src/presentation/item/item_page.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
            path: '/',
            builder: (BuildContext context, GoRouterState state) {
              return const HomePage();
            },
            routes: [
              GoRoute(
                  path: 'item',
                  builder: (BuildContext context, GoRouterState state) {
                    return const ItemPage();
                  }),
            ])
      ]);

  static GoRouter get router => _router;
}
