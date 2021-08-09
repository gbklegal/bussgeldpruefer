import 'package:app/constants.dart';
import 'package:app/functions/newscreen.dart';
import 'package:app/screens/contact.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/pagetitle.dart';
import 'package:flutter/material.dart';

class AblaufScreen extends StatelessWidget {
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
                'So gehst du vor, um erfolgreich Einspruch einzulegen'),
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
              child: Column(
                children: <Widget>[
                  Table(
                    children: [
                      TableRow(
                        children: [
                          Text(''),
                          Text('Vorgang'),
                          Text('Dauer'),
                        ],
                        decoration: _hr(),
                      ),
                      TableRow(
                        children: [
                          _image('assets/images/icons/assignment.png'),
                          Text('Einreichung von Dokumente'),
                          Text('1 Tag'),
                        ],
                        decoration: _hr(),
                      ),
                      TableRow(
                        children: [
                          _image('assets/images/icons/communication.png'),
                          Text('Fallbesprechung mit der Kanzlei'),
                          Text('1 Tag'),
                        ],
                        decoration: _hr(),
                      ),
                      TableRow(
                        children: [
                          _image('assets/images/icons/innovation.png'),
                          Text('Überprüfung / Recherche'),
                          Text('2 Tag'),
                        ],
                        decoration: _hr(),
                      ),
                      TableRow(
                        children: [
                          _image('assets/images/icons/right.png'),
                          Text('Urteil'),
                          Text('4 Tage'),
                        ],
                        decoration: _hr(),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text:
                                'Um einen reibungslosen Ablauf zu gewährleisten, ist es notwendig, dass alle Schritte fristgerecht eingehalten werden.\n')
                      ],
                    ),
                  ),
                  Text(
                      'Um einen reibungslosen Ablauf zu gewährleisten, ist es notwendig, dass alle Schritte fristgerecht eingehalten werden.'),
                  Text(''),
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
                      'Dann rufe uns an oder kontaktier uns über das Kontaktformular und wir kommen innerhalb von 24 Stunden auf Dich zurück.'),
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
