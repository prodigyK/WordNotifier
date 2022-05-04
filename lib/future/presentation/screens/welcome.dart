import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:word_notifier/future/presentation/screens/home_screen.dart';
import 'package:word_notifier/future/presentation/screens/sign_in_screen.dart';

class Welcome extends StatelessWidget {
  static const String routeName = '/welcome';

  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return HomeScreen();
        } else {
          return SignInScreen();
        }
      },
    );
  }
}
