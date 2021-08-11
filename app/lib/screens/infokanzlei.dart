import 'package:app/constants.dart';
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
          color: kSecondaryColor,
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
              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _title('Die Kanzlei'),
                      _text(
                          'Seit vielen Jahren beraten die GBK LEGAL Fachanwaltskanzlei sowie GHR Partnerkanzlein Sachen rund ums Thema Auto und Verkehrsrecht. Unsere Partnerkanzleien sind Experten in allen Rechtsgebieten rund um den Verkehr. Dabei ist ein enger Austausch mit den Mandanten wichtig, um den bestmöglichen Service zu bieten. Unseren Partnerkanzleien ist es wichtig, Dich voll und ganz zu entlasten sowie Angelegenheiten einfach, verständlich zu vermitteln. Führerschein weg? Punkte in Flensburg? Fahrverbot? Als kompetente Berater setzen sich unsere Partnerkanzleien für Dich ein.'),
                      SizedBox(height: 16.0),
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
                              'Unsere Vertragsanwälte sind vertrauenswürdige Partner von BussgeldPrüfer. Du wirst im ständigen Kontakt mit unseren Experten stehen.\n\n- schnell & unkompliziert\n- bundesweit vertreten\n- transparente Kostenübersicht'),
                        ],
                      ),
                      SizedBox(height: 16.0),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _title('Wer wir sind'),
                      _text(
                          'Unsere Partnerkanzleien vertreten Dich deutschlandweit. Sie sind der richtige Ansprechpartner, wenn Du rechtliche Probleme im Verkehr hast, und natürlich in allen anderen Angelegenheiten. Überzeuge Dich selbst von deren Kompetenz.'),
                      SizedBox(height: 16.0),
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
