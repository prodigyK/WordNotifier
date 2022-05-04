import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:word_notifier/future/presentation/bloc/dictionary/search_dictionary_cubit.dart';
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
            child: const Text('RU'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              BlocProvider.of<AppLocaleCubit>(context).updateLocale(const Locale('en'));
            },
            child: const Text('EN'),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () async {

            },
            child: const Text('Load Dictionary'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              final SearchDictionaryCubit dictCubit = BlocProvider.of<SearchDictionaryCubit>(context);
              print(await dictCubit.search('hell'));

            },
            child: const Text('Query'),
          ),
          ElevatedButton(
            onPressed: () async {
              FirebaseAuth.instance.signOut();
            },
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }


}
