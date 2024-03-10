import 'package:go_router/go_router.dart';
import 'package:mini_app/mini_app.dart' as mini_app;

import 'router.dart';

class AppRouter {
  // Combine routes from your app and mini app
  static final List<RouteBase> _combinedRoutes = List.from($appRoutes)
    ..addAll(mini_app.$appRoutes);

  static final GoRouter _router = GoRouter(
      initialLocation: const AuthRoute().location,
      debugLogDiagnostics: true,
      redirect: (_, __) => null,
      routes: _combinedRoutes);

  static GoRouter get router => _router;
}
