import 'package:app/functions/newscreen.dart';
import 'package:app/screens/contact.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/pagetitle.dart';
import 'package:flutter/material.dart';

class QuickCheckFinalScreen extends StatelessWidget {
  _padding() {
    return SizedBox(height: 22.0);
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
                  Image.asset('assets/icons/traffic-light.png', height: 80),
                  Text(
                    'Eine Verteidigung gegen den behaupteten "XYZ" erscheint "XZY".*',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  _padding(),
                  Image.asset('assets/icons/happy.png', height: 80),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => print('Prüfung Bußgeldbescheid'),
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
                      Image.asset('assets/icons/driving-license.png',
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
                              icon: Icon(Icons.save_outlined),
                              onPressed: () => print('save'),
                            ),
                            Text('speichern'),
                          ],
                        ),
                      ),
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
