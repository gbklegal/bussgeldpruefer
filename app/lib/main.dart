import 'package:app/global.dart';
import 'package:app/helper/helperfunctions.dart';
import 'package:app/provider/google_sign_in.dart';
import 'package:app/screens/auth/login.dart';
import 'package:app/screens/messages/conversationscreen.dart';
import 'package:app/screens/profile/profiledata.dart';
import 'package:app/screens/pruefungbussgeldbescheidfinal.dart';
import 'package:app/services/connectivity.dart';
import 'package:app/utilities/theme_data.dart';
import 'package:badges/badges.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/screens/quickcheck.dart';
import 'package:app/screens/home.dart';
import 'package:provider/provider.dart';

// only for development
// import 'package:app/screens/dummy.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //   badge: true,
  // );
  runApp(
    ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        theme: themeData,
        home: MyApp(), // In prod. MyApp()
        routes: <String, WidgetBuilder>{
          '/screen1': (BuildContext context) => new MyApp(),
          '/screen2': (BuildContext context) =>
              new PruefungBussgeldbescheidFinalScreen(),
          '/ProfileData': (BuildContext context) => new ProfileData(),
          '/LoginScreen': (BuildContext context) => new LoginScreen()
        },
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('de', 'DE'),
        ],
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  int _currentIndex = 1; // default: 1
  final List<Widget> _tabs = [
    QuickCheckScreen(),
    HomeScreen(),
    ProfileData(),
  ];
  bool userIsLoggedIn;

  Future initFCM() async {
    isConnection = await ConnectionStatus().checkConnectionStatus();
    FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      //If there is data in our notification
      if (message != null) {
        //We will open the route from the field view
        //with the value definied in the notification
        var chatRoomId = message.data['chatroomid'];
        List<String> listOfUsers = message.data['users'];
        print("abcd:" + listOfUsers.toString());
        Navigator.push(
            _scaffoldKey.currentContext,
            MaterialPageRoute(
                builder: (_) => ConversationScreen(chatRoomId, listOfUsers)));
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage event) async {
      // var message = event.data['chatroomid'];
      // var listOfUsers = message.data['users'];

      var chatRoomId = event.data['chatroomid'];
      List<String> listOfUsers = event.data['users'];
      print("abcd:" + listOfUsers.toString());
      Navigator.push(
          _scaffoldKey.currentContext,
          MaterialPageRoute(
              builder: (_) => ConversationScreen(chatRoomId, listOfUsers)));
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      var chatRoomId = message.data['chatroomid'];
      List<String> listOfUsers = message.data['users'];
      print("abcd:" + listOfUsers.toString());
      Navigator.push(
          _scaffoldKey.currentContext,
          MaterialPageRoute(
              builder: (_) => ConversationScreen(chatRoomId, listOfUsers)));
    });
  }

  @override
  void initState() {
    super.initState();
    initFCM();
    getLoggedInState();
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
      key: _scaffoldKey,
      appBar: AppBarWidget(isHome: true),
      body:
          // Container(
          //     child: Center(
          //   child: Text("Message: " + _message),
          // )),
          _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xff183B63),
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
