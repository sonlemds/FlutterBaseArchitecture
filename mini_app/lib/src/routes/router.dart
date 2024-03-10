import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_app/src/presentation/home/home_page.dart';
import 'package:mini_app/src/presentation/item/item_page.dart';

part 'router.g.dart';

@TypedGoRoute<MiniAppRoute>(
  path: '/mini-app',
)
@immutable
class MiniAppRoute extends GoRouteData {
  const MiniAppRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomePage();
  }
}

@TypedGoRoute<ItemRoute>(
  path: '/mini-app/item',
)
@immutable
class ItemRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ItemPage();
  }
}
