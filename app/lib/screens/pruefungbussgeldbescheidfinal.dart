import 'package:app/constants.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/allconfetti.dart';
import 'package:app/widgets/pagetitle.dart';
import 'package:flutter/material.dart';

class PruefungBussgeldbescheidFinalScreen extends StatefulWidget {
  @override
  _PruefungBussgeldbescheidFinalScreenState createState() =>
      _PruefungBussgeldbescheidFinalScreenState();
}

class _PruefungBussgeldbescheidFinalScreenState
    extends State<PruefungBussgeldbescheidFinalScreen> {
  _title(text) {
    return Text(
      text,
      style: TextStyle(fontSize: 22.0, color: kSecondaryColor),
    );
  }

  _padding([height = 20.0]) {
    return SizedBox(height: height);
  }

  Future<bool> _willPopCallback() async {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/screen1', (Route<dynamic> route) => false);
    return false; // return true if the route to be popped
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        appBar: AppBarWidget(),
        body: ListView(
          children: <Widget>[
            PageTitle('Prüfung Bußgeldbescheid'),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Geschafft!',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: kSecondaryColor),
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(text: 'Der Antrag wurde '),
                        TextSpan(
                          text: 'erfolgreich',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: ' eingereicht.'),
                      ],
                    ),
                  ),
                  _padding(),
                  Align(
                    alignment: Alignment.center,
                    child: AllConfettiWidget(
                      child: Image.asset('assets/images/icons/confetti.png',
                          height: 80),
                    ),
                  ),
                  _padding(),
                  _title('Was passiert als Nächstes?'),
                  Table(
                    columnWidths: <int, TableColumnWidth>{
                      0: IntrinsicColumnWidth(),
                    },
                    children: <TableRow>[
                      TableRow(
                        children: <Widget>[
                          Text(
                            '1.',
                            style: TextStyle(color: kSecondaryColor),
                          ),
                          Text(
                              'Du erhältst nun eine E-Mail mit allen wichtigen Daten.'),
                        ],
                      ),
                      TableRow(
                        children: <Widget>[
                          Text(
                            '2.',
                            style: TextStyle(color: kSecondaryColor),
                          ),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                    text:
                                        'Die Anwaltskanzlei meldet sich bei dir in 24 Stunden.'),
                                TextSpan(
                                    text:
                                        '\n(Es entstehen keine Anwaltskosten.)',
                                    style: TextStyle(fontSize: 12)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  _padding(),
                  Text(
                      'Du willst dich über den aktuellen Status deines Falls informieren?\nDann eröffne einen Account bei BussgeldPruefer!\n- Information über Deinen aktuellen Status\n- Direkter Austausch mit der Partnerkanzlei\n- Einfacher Upload Deiner Dokumente'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
