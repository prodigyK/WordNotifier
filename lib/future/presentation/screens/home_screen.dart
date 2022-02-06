import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:word_notifier/future/presentation/bloc/locale/app_locale_cubit.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isRu = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text(AppLocalizations.of(context)!.words)),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              BlocProvider.of<AppLocaleCubit>(context).updateLocale(const Locale('ru'));
            },
            child: Text('RU'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              BlocProvider.of<AppLocaleCubit>(context).updateLocale(const Locale('en'));
            },
            child: Text('EN'),
          ),
        ],
      ),
    );
  }
}
