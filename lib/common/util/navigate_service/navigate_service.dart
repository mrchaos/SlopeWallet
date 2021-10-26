

import 'package:flutter/material.dart';

final rootNavigateService = NavigateService('root_navigate_key');
final RouteObserver<Route> rootRouteObserver = RouteObserver<Route>();

BuildContext get appRootContext => rootNavigateService.appRootContext;

class NavigateService {
  GlobalKey<NavigatorState>? _key;
  final String navigatorLabel;

  GlobalKey<NavigatorState>? get key => _key;

  NavigateService(this.navigatorLabel) {
    _key = GlobalKey(debugLabel: navigatorLabel);
  }
  ///NavigatorState，BuildContext
  NavigatorState? get navigatorState => key!.currentState;

  BuildContext get appRootContext => navigatorState!.context;
}
