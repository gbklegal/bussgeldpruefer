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
                          'Seit vielen Jahren beraten die GBK LEGAL Fachanwaltskanzlei sowie GHR Partnerkanzlei rund ums Thema Auto und Verkehrsrecht. Unsere Partnerkanzleien sind Experten in allen Themen zum Verkehr. Dabei ist uns ein enger Austausch mit den Mandaten stets wichtig, um den bestmöglichen Service zu bieten. Ziel unserer Partnerkanzleien ist es, Dich voll und ganz zu entlasten sowie einfach und verständlich Deinen Fall zu führen. Führerschein weg? Punkte in Flensburg? Fahrverbot? Als kompetente Berater setzen sich unsere Partnerkanzleien für Dich ein.'),
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
                          'BussgeldPrüfer wird durch einen gemeinsamen Auftritt verschiedener Dienstleister realisiert. Dabei haben wir nur ein Ziel:\nDir ein umfassendes Informations-Paket zum Thema Bußgeldbescheid mit zahlreichen allgemeinen Tipps zur Verfügung zu stellen.\nRatsuchende können sich vorab über die Thematik informieren und selbst einschätzen, ob sie eine persönliche professionelle und persönliche Beratung und Vertretung in Bußgeldangelegenheiten benötigen. Lass uns Deine Anlaufstelle zum Thema Prüfung Deines Bußgeldbescheides sein!'),
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
