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
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Wordify'),
        elevation: 1,
        backgroundColor: Colors.orange,
        toolbarHeight: 80,
      ),
      body: screens[selectedIndex]['screen'],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        backgroundColor: Colors.white38,
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
    );
  }
}
