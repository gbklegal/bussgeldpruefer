import 'package:flutter/material.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/pagetitle.dart';

class ManualScreen extends StatelessWidget {
  _text(text) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: 12.0),
        child: Text(
          text,
          softWrap: true,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  _image(name) {
    return Image.asset(
      name,
      width: 88,
      height: 88,
    );
  }

  _hr() {
    return Column(
      children: [
        SizedBox(height: 12.0),
        Divider(
          height: 20,
          thickness: 2,
          color: Colors.black26,
        ),
        SizedBox(height: 12.0),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            PageTitle(
              'Anleitung',
              'Wie funktioniert der BussgeldPrüfer?',
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 0.0,
                right: 20.0,
                bottom: 20.0,
                left: 20.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Akzeptiere deinen Bußgeldbescheid nicht voreilig.',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 12.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            _image('assets/images/icons/checklist.png'),
                            _text(
                              'Per Quick-Check erhältst Du in weniger als 1 Minute mithilfe unserer KI-basierten Software eine unverbindliche Einschätzung Deines Falls.',
                            ),
                          ],
                        ),
                        _hr(),
                        Row(
                          children: [
                            _image('assets/images/icons/lawyer.png'),
                            _text(
                              'Sofort oder nach Deinem Quick-Check kannst Du eine verbindliche kostenlose Ersteinschätzung durch unsere Partneranwälte beauftragen.',
                            ),
                          ],
                        ),
                        _hr(),
                        Row(
                          children: [
                            _image('assets/images/icons/homesecurity.png'),
                            _text(
                              'Nach Bewertung und Prüfung Deines Falles entscheidest Du, ob unsere Vertragsanwälte die Verteidigung im Bußgeldverfahren für Dich übernehmen und die Einstellung anstreben sollen.',
                            ),
                          ],
                        ),
                      ],
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
