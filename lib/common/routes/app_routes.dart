import 'package:flutter/cupertino.dart';
import 'package:word_notifier/future/presentation/screens/home_screen.dart';
import 'package:word_notifier/future/presentation/screens/sign_in_screen.dart';
import 'package:word_notifier/future/presentation/screens/welcome.dart';

typedef routeFunc = Widget Function(BuildContext);

class AppRoutes {
  static Map<String, routeFunc> get routes {
    return {
      Welcome.routeName: (_) => Welcome(),
      HomeScreen.routeName: (_) => HomeScreen(),
      SignInScreen.routeName: (_) => SignInScreen(),
    };
  }
}