import 'package:app/functions/newscreen.dart';
import 'package:app/screens/dummy.dart';
import 'package:app/widgets/pagetitle.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  _padding() {
    return SizedBox(height: 20.0);
  }

  _imageTextButton({icon, text, context, screen}) {
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
              Icon(
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
                  screen: DummyScreen(),
                ),
                _padding(),
                _imageTextButton(
                  icon: Icons.rotate_right_outlined,
                  text: 'Überprüfe den aktuellen Status Deines Falls',
                  context: context,
                  screen: DummyScreen(),
                ),
                _padding(),
                _imageTextButton(
                  icon: Icons.cloud_upload_outlined,
                  text: 'Dokumenten Übersicht',
                  context: context,
                  screen: DummyScreen(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
