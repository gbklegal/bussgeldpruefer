import 'package:flutter/material.dart';

import '../widgets/appbar.dart';
import '../widgets/pagetitle.dart';

class InfoKanzleiScreen extends StatelessWidget {
  _text(text) {
    return Text(
      text,
      style: TextStyle(fontSize: 15.0),
    );
  }

  _title(text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        hideInfoButton: false,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            PageTitle(
              'Deine Experten im Verkehrsrecht',
              'Unsere Partnerkanzleien und Vertragsanwälte',
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 0.0,
                right: 20.0,
                bottom: 20.0,
                left: 20.0,
              ),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _title('Die Kanzlei'),
                      _text(
                          'Seit vielen Jahren berät die /// GBK Legal Kanzlei in Sachen Verkehrsrecht. Wir sind der Experte in allen Rechtsgebieten rund um Verkehr. Uns ist ein enger Austausch mit den Klienten wichtig, um den bestmöglichen Service zu bieten. GBK ist darauf spezialisiert deine Rechte im Verkehr zu verteidigen. Dabei ist es uns wichtig, Dich voll und ganz zu entlasten und Angelegenheiten einfach, verständlich zu vermitteln. Führerschein weg? Punkte in Flensburg? Fahrverbot? MPU-Test? Wir sind Experten auf diesem Gebiet. Als kompetente Berater setzen wir uns für Dich ein.'),
                      SizedBox(height: 12.0),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _title('Deine Vorteile'),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _text(
                              'Unsere Vertragsanwälte sind vertrauenswürdige Partner von BussgeldPrüfer. Du wirst im ständigen Kontakt mit unseren Experten stehen.'),
                          SizedBox(height: 12.0),
                          _text('- schnell & unkompliziert'),
                          _text('- bundesweit vertreten'),
                          _text('- transparente Kostenübersicht'),
                        ],
                      ),
                      SizedBox(height: 12.0),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _title('Wer wir sind'),
                      _text(
                          'Unsere Partnerkanzleien vertreten Dich deutschlandweit. Sie sind der richtige Ansprechpartner, wenn Du rechtliche Probleme im Verkehr hast, und natürlich in allen anderen Angelegenheiten. Überzeuge Dich selbst von deren Kompetenz.'),
                      SizedBox(height: 12.0),
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
