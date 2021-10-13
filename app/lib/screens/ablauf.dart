import 'package:app/constants.dart';
import 'package:app/functions/newscreen.dart';
import 'package:app/screens/contact.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/pagetitle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'auth/login.dart';

class AblaufScreen extends StatefulWidget {
  @override
  _AblaufScreenState createState() => _AblaufScreenState();
}

class _AblaufScreenState extends State<AblaufScreen> {
  _image(name) {
    return Image.asset(
      name,
      width: 88,
      height: 88,
    );
  }

  _hr() {
    return BoxDecoration(
      border: Border(
        bottom: BorderSide(width: 1.5, color: Colors.black38),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            PageTitle('Bußgeldbescheid erhalten?',
                'So gehst Du mit BussgeldPrüfer dagegen vor:'),
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
              child: Column(
                children: <Widget>[
                  Table(
                    children: [
                      TableRow(
                        children: [
                          Text(''),
                          Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              child: Text('Vorgang')),
                        ],
                        decoration: _hr(),
                      ),
                      TableRow(
                        children: [
                          _image('assets/images/icons/assignment.png'),
                          Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              child: Text('Einreichung von Dokumente')),
                        ],
                        decoration: _hr(),
                      ),
                      TableRow(
                        children: [
                          _image('assets/images/icons/communication.png'),
                          Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                  'Anfrage Akteneinsicht und notfalls Einspruch durch Kanzlei')),
                        ],
                        decoration: _hr(),
                      ),
                      TableRow(
                        children: [
                          _image('assets/images/icons/innovation.png'),
                          Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                  'Überprüfung / anwaltliche Empfehlung fürs weitere Vorgehen')),
                        ],
                        decoration: _hr(),
                      ),
                      TableRow(
                        children: [
                          _image('assets/images/icons/right.png'),
                          Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                  'Entscheidung durch Behörde oder Gericht')),
                        ],
                        decoration: _hr(),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Text(
                      'Jetzt schnell beauftragen, bevor Du Rechtsnachteile erleidest.'),
                  SizedBox(height: 20.0),
                  FirebaseAuth.instance.currentUser == null
                      ? SizedBox(
                          width: 200.0,
                          child: ElevatedButton(
                            child: Text('Login'),
                            style: ElevatedButton.styleFrom(
                              textStyle: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              primary: Color(0xff5CC8C5),
                              onPrimary: Colors.white,
                            ),
                            onPressed: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (BuildContext context) =>
                              //             LoginScreen()));
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          LoginScreen()),
                                  ModalRoute.withName('/'));
                              setState(() {});
                            },
                          ),
                        )
                      : SizedBox(),
                  SizedBox(height: 20.0),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Du brauchst Hilfe?',
                      style: TextStyle(
                        color: kSecondaryColor,
                      ),
                    ),
                  ),
                  Text(
                      'Rufe uns an oder kontaktiere uns über das Kontaktformular und wir melden uns in der Regel innerhalb von 24 Stunden bei Dir.'),
                  Text(''),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => newScreen(
                        context: context,
                        screen: ContactScreen(),
                      ),
                      child: Text('Kontaktformular'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
