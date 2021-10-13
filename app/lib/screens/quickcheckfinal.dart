import 'package:app/functions/newscreen.dart';
import 'package:app/screens/contact.dart';
import 'package:app/screens/pruefungbussgeldbescheid.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/pagetitle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'auth/login.dart';

// ignore: must_be_immutable
class QuickCheckFinalScreen extends StatelessWidget {
  final String violationName;
  final String trafficLightColor;
  String status;
  QuickCheckFinalScreen({this.violationName, this.trafficLightColor});

  _padding() {
    return SizedBox(height: 22.0);
  }

  _translateColor(color) {
    String text;
    if (color == 'red') text = 'nicht ';
    if (color == 'yellow') text = 'zunächst ';
    _checkStatus(color);
    return text;
  }

  _checkStatus(color) {
    if (color == 'red') status = 'nicht möglich';
    if (color == 'yellow') status = 'bedingt möglich';
    if (color == 'green') status = 'möglich';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            PageTitle('Quick Check'),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Text(
                'Fast geschafft!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                20.0,
                0.0,
                20.0,
                20.0,
              ),
              child: Column(
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: 16.0),
                      children: <TextSpan>[
                        TextSpan(text: '\nDie Ersteinschätzung war '),
                        TextSpan(text: _translateColor(trafficLightColor)),
                        TextSpan(
                            text: 'erfolgreich',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text:
                                '.\nAufgrund Deiner Angaben kommen unsere Partneranwälte zu folgendem vorläufigen Ergebnis (vorbehaltlich zukünftiger Erkenntnisse): *',
                            style: TextStyle(fontSize: 8)),
                      ],
                    ),
                  ),
                  _padding(),
                  Image.asset(
                    'assets/images/icons/traffic-light-$trafficLightColor.png',
                    height: 130,
                  ),
                  _padding(),
                  Text(
                    'Eine Verteidigung gegen den behaupteten $violationName-Verstoß erscheint $status.*',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  _padding(),
                  (trafficLightColor == 'red')
                      ? Image.asset('assets/images/icons/sad.png', height: 80)
                      : (trafficLightColor == 'yellow')
                          ? Image.asset('assets/images/icons/happy.png',
                              height: 80)
                          : Image.asset('assets/images/icons/happy.png',
                              height: 80),
                  _padding(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        FirebaseAuth.instance.currentUser == null
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        LoginScreen()))
                            : newScreen(
                                context: context,
                                screen: PruefungBussgeldbescheidScreen(),
                              );
                      },
                      child: Text(
                        'Jetzt Bußgeldbescheid prüfen lassen',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  _padding(),
                  Text(
                    'Nur 1 Schritt fehlt, um den Bescheid anzufechten',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                      '\n- durch Anwalt geprüft\n- Rückmeldung binnen 24 h\n- kostenlose Erstberatung'),
                  _padding(),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '$violationName-Verstoß kann im schlimmsten Fall zum Führerscheinverlust führen.',
                          style:
                              TextStyle(fontSize: 18, color: Color(0xff5CC8C5)),
                          softWrap: true,
                        ),
                      ),
                      Image.asset('assets/images/icons/driving-license.png',
                          width: 70),
                    ],
                  ),
                  _padding(),
                  Text(
                    '* Einschätzung basiert ausschließlich und allein auf den von Ihnen getätigten Angaben. Bussgeldprüfer und dessen Anbieter ist kein Rechtsdienstleister nach dem Rechtsdienstleistungsgesetz (RDG), und erteilt selbst keinerlei Rechtsberatung. Diese ist den dafür zugelassenen Rechtsanwälte und den Partnerkanzleien vorbehalten.',
                    style: TextStyle(fontSize: 8),
                  ),
                  _padding(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Du hast Fragen?\nDann kontaktier uns!',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => newScreen(
                        context: context,
                        screen: ContactScreen(),
                      ),
                      child: Text(
                        'Kontaktformular',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  _padding(),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.refresh),
                              onPressed: () => Navigator.pop(context),
                            ),
                            Text('neu starten'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () => Navigator.pop(context),
                            ),
                            Text('Beenden'),
                          ],
                        ),
                      ),
                    ],
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
