import 'package:app/functions/newscreen.dart';
import 'package:app/main.dart';
import 'package:app/screens/profiledocumentsoverview.dart';
import 'package:app/screens/profileinbox.dart';
import 'package:app/screens/profilestatus.dart';
import 'package:app/widgets/pagetitle.dart';
import 'package:badges/badges.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../global.dart';

class ProfileData extends StatelessWidget {
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
                SizedBox(
                  width: 200.0,
                  child: ElevatedButton(
                    child: Text('Logout'),
                    style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      primary: Color(0xff5CC8C5),
                      onPrimary: Colors.white,
                    ),
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => MyApp()));
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
