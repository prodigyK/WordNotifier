import 'package:flutter/material.dart';
import 'package:word_notifier/future/presentation/screens/home_screen.dart';
import 'package:word_notifier/future/presentation/screens/search_screen.dart';
import 'package:word_notifier/future/presentation/screens/settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

List<Map<String, dynamic>> screens = [
  {
    'label': 'Words',
    'screen': HomeScreen(),
    'icon': Icons.menu_book,
  },
  {
    'label': 'Search',
    'screen': SearchScreen(),
    'icon': Icons.search,
  },
  {
    'label': 'Settings',
    'screen': SettingsScreen(),
    'icon': Icons.settings,
  },
];

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: screens[selectedIndex]['screen'],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                  blurRadius: 3,
                  // spreadRadius: 1.0,
                  color: Theme.of(context).primaryColor.withOpacity(0.5))
            ]),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          child: BottomNavigationBar(
            currentIndex: selectedIndex,
            // backgroundColor: CupertinoColors.systemBackground,
            backgroundColor: Theme.of(context).primaryColor,
            selectedItemColor: Colors.green,
            unselectedItemColor: Colors.white,
            elevation: 8,
            // iconSize: 28,
            items: screens
                .map((item) => BottomNavigationBarItem(
                      icon: Icon(item['icon']),
                      label: item['label'],
                    ))
                .toList(),
            onTap: (value) {
              setState(() {
                selectedIndex = value;
              });
            },
          ),
        ),
      ),
    );
  }
}
