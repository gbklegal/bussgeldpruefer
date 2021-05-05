import 'package:app/functions/newscreen.dart';
import 'package:app/screens/profiledocumentsoverview.dart';
import 'package:app/screens/profileinbox.dart';
import 'package:app/screens/profilestatus.dart';
import 'package:app/widgets/pagetitle.dart';
import 'package:badges/badges.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../global.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User user;

  bool isloggedin = false;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.of(context).pushReplacementNamed("start");
      }
    });
  }

  getUser() async {
    User firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isloggedin = true;
      });
    }
  }

  signOut() async {
    _auth.signOut();
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
    this.getUser();
  }

  _padding() {
    return SizedBox(height: 20.0);
  }

  _imageTextButton({icon, text, context, screen, bool badge: false}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => newScreen(
          context: context,
          screen: screen,
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              badge
                  ? Badge(
                      child: Icon(
                        icon,
                        size: 40,
                      ),
                      badgeContent: Text(
                        '$inboxUnreadBadgeCount',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : Icon(
                      icon,
                      size: 40,
                    ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(fontSize: 20),
                  softWrap: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: <Widget>[
          PageTitle('Mein Profil'),
          Padding(
            padding: EdgeInsets.fromLTRB(
              20.0,
              0.0,
              20.0,
              20.0,
            ),
            child: Column(
              children: <Widget>[
                Text(
                    'In deinem Profil kannst du auf alle wichtigen Unterlagen jederzeit zugreifen.'),
                _padding(),
                _padding(),
                _imageTextButton(
                  icon: Icons.email_outlined,
                  text: 'Online Posteingang',
                  context: context,
                  screen: ProfileInboxScreen(),
                  badge: true,
                ),
                _padding(),
                _imageTextButton(
                  icon: Icons.rotate_right_outlined,
                  text: 'Überprüfe den aktuellen Status Deines Falls',
                  context: context,
                  screen: ProfileStatusScreen(),
                ),
                _padding(),
                _imageTextButton(
                  icon: Icons.cloud_upload_outlined,
                  text: 'Dokumentenübersicht',
                  context: context,
                  screen: ProfileDocumentsOverviewScreen(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
