import 'package:app/global.dart';
import 'package:app/helper/helperfunctions.dart';
import 'package:app/screens/authenticate/login.dart';
import 'package:app/screens/profile/profiledata.dart';
import 'package:badges/badges.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/screens/quickcheck.dart';
import 'package:app/screens/home.dart';

// only for development
// import 'package:app/screens/dummy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      home: MyApp(), // In prod. MyApp()
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('de', 'DE'),
      ],
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 1; // default: 1
  final List<Widget> _tabs = [
    QuickCheckScreen(),
    HomeScreen(),
    ProfileData(),
  ];
  bool userIsLoggedIn;

  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    await HelperFunctions().getUserLoggedInSharedPreference().then((value) {
      print(userIsLoggedIn.toString());
      setState(() {
        userIsLoggedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(isHome: true),
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
            icon: _currentIndex == 0
                ? Icon(Icons.check_circle)
                : Icon(Icons.check_circle_outline),
            label: 'Quick Check',
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 1
                ? Icon(Icons.home)
                : Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Badge(
              child: _currentIndex == 2
                  ? Icon(Icons.person)
                  : Icon(Icons.person_outline),
              badgeContent: Text(
                '$inboxUnreadBadgeCount',
                style: TextStyle(color: Colors.white),
              ),
            ),
            label: 'Profil',
          ),
        ],
        onTap: (index) {
          if (index == 2) {
            if (FirebaseAuth.instance.currentUser == null) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginScreen()));
            } else {
              setState(() {
                _currentIndex = index;
              });
            }
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
      ),
    );
  }
}
