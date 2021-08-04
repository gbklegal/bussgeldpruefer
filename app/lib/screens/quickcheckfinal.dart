import 'package:app/functions/newscreen.dart';
import 'package:app/screens/contact.dart';
import 'package:app/screens/pruefungbussgeldbescheid.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/pagetitle.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class QuickCheckFinalScreen extends StatelessWidget {
  final String voilationName;
  final String trafficLightColor;
  String status;
  QuickCheckFinalScreen({this.voilationName, this.trafficLightColor});

  _padding() {
    return SizedBox(height: 22.0);
  }

  _translateColor(color) {
    String text;
    if (color == 'red') text = 'nicht möglich';
    if (color == 'yellow') text = 'bedingt möglich';
    if (color == 'green') text = 'möglich';
    status = text;
    return text;
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
                        TextSpan(
                            text: 'Fast geschafft!',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: '\nDie Ersteinschätzung war '),
                        TextSpan(text: _translateColor(trafficLightColor)),
                        TextSpan(
                            text: ' erfolgreich',
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
                    height: 80,
                  ),
                  Text(
                    'Eine Verteidigung gegen den behaupteten "$voilationName" erscheint "$status".*',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  _padding(),
                  Image.asset('assets/images/icons/happy.png', height: 80),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => newScreen(
                        context: context,
                        screen: PruefungBussgeldbescheidScreen(),
                      ),
                      child: Text(
                        'Prüfung Bußgeldbescheid',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  _padding(),
                  Text('Nur 1 Schritt fehlt, um den Bescheid anzufechten'),
                  Text(
                      '\n- Druch Anwalt geprüft\n- in 24h Rückmeldung\n- kostenlose Ersteberatung'),
                  _padding(),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '"XYZ" kann im schlimmsten Fall zum Führerscheinverlust führen.',
                          style: TextStyle(fontSize: 18, color: Colors.blue),
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
                              onPressed: () => print('restart'),
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
