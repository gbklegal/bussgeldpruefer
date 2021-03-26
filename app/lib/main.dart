import 'package:flutter/material.dart';

import 'package:app/widgets/appbar.dart';

import 'package:app/screens/quickcheck.dart';
import 'package:app/screens/home.dart';
import 'package:app/screens/profile.dart';

// only for development
import 'package:app/screens/manual.dart';

void main() => runApp(
      MaterialApp(
        home: ManualScreen(), // In prod. MyApp()
        debugShowCheckedModeBanner: false,
      ),
    );

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 1;

  final List<Widget> _tabs = [
    Camera(),
    HomeScreen(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        isHome: true,
        hideInfoButton: false,
      ),
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            label: 'Quick Check',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profil',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
