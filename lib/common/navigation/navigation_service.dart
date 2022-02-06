import 'package:flutter/material.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Future<dynamic> navigationTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  static Future<dynamic> navigationWithDataTo(String routeName, Object arguments) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
  }

  static void pop() {
    return navigatorKey.currentState!.pop();
  }
}