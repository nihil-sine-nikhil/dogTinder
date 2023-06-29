import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  const AppRouter({
    required List<AppRoute> routes,
    required Handler notFoundHandler,
  })  : _routes = routes,
        _notFoundHandler = notFoundHandler;

  static FluroRouter router = FluroRouter.appRouter;

  final Handler _notFoundHandler;
  final List<AppRoute> _routes;

  List<AppRoute> get routes => _routes;

  void setupRoutes() {
    router.notFoundHandler = _notFoundHandler;
    routes.forEach(_getRoutes);
  }

  void _getRoutes(AppRoute route) {
    return router.define(
      route.route,
      handler: route.handler as Handler,
      transitionType: TransitionType.fadeIn,
    );
  }

  static Future navigateTo(
    String path, {
    bool replace = false,
    bool clearStack = false,
    TransitionType? transition,
    Duration transitionDuration = const Duration(milliseconds: 250),
    RouteTransitionsBuilder? transitionBuilder,
  }) {
    final context = navigatorKey.currentState?.context;
    if (context != null) {
      return router.navigateTo(
        context,
        path,
        replace: replace,
        clearStack: clearStack,
        transition: transition,
        transitionDuration: transitionDuration,
        transitionBuilder: transitionBuilder,
      );
    } else {
      throw Exception('Navigator did not find the context');
    }
  }
}
