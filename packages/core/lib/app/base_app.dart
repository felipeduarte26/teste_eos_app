import 'package:flutter/material.dart';

import '../core.dart';

base mixin BaseApp {
  List<MicroApp> get microApps;

  Map<String, WidgetBuilderArgs> get baseRoutes;

  final Map<String, WidgetBuilderArgs> routes = {};

  void registerAllDependencies() {
    if (baseRoutes.isNotEmpty) routes.addAll(baseRoutes);

    if (microApps.isNotEmpty) {
      for (final MicroApp microApp in microApps) {
        routes.addAll(microApp.routes);

        microApp
          ..injectionsRegister()
          ..listenerRegister();
      }
    }
  }

  Route<dynamic>? generateRoute(RouteSettings settings) {
    final routerName = settings.name;
    final routerArgs = settings.arguments;
    final Arguments? args = routerArgs as Arguments?;

    final navigateTo = routes[routerName];
    if (navigateTo == null) return null;

    return MaterialPageRoute(
      builder: (context) => navigateTo.call(
        context,
        args,
      ),
    );
  }
}
