import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  static const String routeName = '/sign-in';

  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool signIn = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();
  int _sliding = 0;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          margin: const EdgeInsets.symmetric(horizontal: 32),
          // decoration: const BoxDecoration(
          //     gradient: LinearGradient(
          //         colors: [
          //           Colors.lightBlue,
          //           Colors.orange,
          //         ],
          //         begin: Alignment.topCenter,
          //         end: Alignment.bottomCenter,
          //         stops: [0.0, 0.5]
          //     )
          // ),
          child: SafeArea(
            child: Column(
              children: [
                const Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(
                      'Wordify',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: _buildAuthForm(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _buildAuthForm(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.mail),
                  labelText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_passwordFocus);
                },
                validator: (value) {
                  final val = value ?? '';
                  if (val.isEmpty) {
                    return 'Email cannot be empty.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                focusNode: _passwordFocus,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.security),
                  labelText: 'Password',
                ),
                keyboardType: TextInputType.text,
                obscureText: true,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) {
                  // _submitForm();
                },
                validator: (value) {
                  final val = value ?? '';
                  if (val.isEmpty) {
                    return 'Password cannot be empty.';
                  }
                  return null;
                },
              ),
              if (!signIn)
                TextFormField(
                  controller: _confirmPasswordController,
                  focusNode: _confirmPasswordFocus,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.security),
                    labelText: 'Confirm Password',
                  ),
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) {
                    // _submitForm();
                  },
                  validator: (value) {
                    final val = value ?? '';
                    if (val.isEmpty) {
                      return 'Password cannot be empty.';
                    }
                    return null;
                  },
                ),
              const SizedBox(height: 50),
              Row(
                children: [
                  Expanded(
                    child: CupertinoButton(
                      color: Colors.blue.shade300,
                      child: const Text('Sign In'),
                      onPressed: _submitForm,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: CupertinoSlidingSegmentedControl(
            groupValue: _sliding,
            // padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            // backgroundColor: CupertinoColors.systemGrey,
            onValueChanged: (value) {
              setState(() {
                if (value is int) {
                  _sliding = value;
                  signIn = value == 0;
                }
              });
              print(value);
            },
            children: <int, Widget>{
              0: _buildLoginMode(context, label: 'Sign In'),
              1: _buildLoginMode(context, label: 'Sign Up'),
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLoginMode(BuildContext context, {required String label}) {
    return Container(
      width: 90,
      height: 50,
      child: Center(child: Text(label)),
    );
  }

  _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    try {
      if (signIn) {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
      } else {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _showSnackbar('User not found: ${e.message}', error: true);
      } else if (e.code == 'wrong-password') {
        _showSnackbar('Wrong password provided: ${e.message}', error: true);
      } else {
        _showSnackbar(e.message ?? 'unknown error', error: true);
      }
      return;
    }
  }

  void _showSnackbar(String message, {bool error = false}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, textAlign: TextAlign.center),
        duration: const Duration(seconds: 5),
        backgroundColor: error ? Colors.red : Colors.black,
      ),
    );
  }
}
