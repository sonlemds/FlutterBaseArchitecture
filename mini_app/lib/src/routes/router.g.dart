// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $miniAppRoute,
      $itemRoute,
    ];

RouteBase get $miniAppRoute => GoRouteData.$route(
      path: '/mini-app',
      factory: $MiniAppRouteExtension._fromState,
    );

extension $MiniAppRouteExtension on MiniAppRoute {
  static MiniAppRoute _fromState(GoRouterState state) => const MiniAppRoute();

  String get location => GoRouteData.$location(
        '/mini-app',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $itemRoute => GoRouteData.$route(
      path: '/mini-app/item',
      factory: $ItemRouteExtension._fromState,
    );

extension $ItemRouteExtension on ItemRoute {
  static ItemRoute _fromState(GoRouterState state) => ItemRoute();

  String get location => GoRouteData.$location(
        '/mini-app/item',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
