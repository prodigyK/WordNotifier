import 'package:flutter/cupertino.dart';
import 'package:word_notifier/future/presentation/screens/home_screen.dart';

typedef routeFunc = Widget Function(BuildContext);

class AppRoutes {
  static Map<String, routeFunc> get routes {
    return {
      HomeScreen.routeName: (_) => HomeScreen(),
    };
  }
}