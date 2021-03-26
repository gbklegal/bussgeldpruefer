// import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

import '../widgets/appbar.dart';
import '../widgets/pagetitle.dart';

class FaqScreen extends StatefulWidget {
  @override
  _FaqScreenState createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            PageTitle('FAQ', 'Häufig gestellte Fragen'),
            ExpansionPanelList(
              children: [
                ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return Text('Welche Kosten kommen auf mich zu?');
                  },
                  isExpanded: true,
                  body: Container(
                    child: Text(
                        'Grundsätzlich sind die Leistungen über BussgeldPrüfer kostenlos. Insbesondere können Sie über BussgeldPrüfer grundsätzlich vorerst eine unverbindliche und kostenlose Erstberatung beauftragen und mandatieren. Auf Wunsch beantragt ein hierzu befugter Anwalt für Sie Akteneinsicht in Ihre amtliche Ermittlungsakte. Hierfür berechnet der von Ihnen beauftragte Anwalt lediglich eine pauschale Akteneinsichtsgebühr in Höhe von 13,92 EUR inklusive Mehrwertsteuer. Die Arbeit der Anwälte ist auch in diesem Schritt für Sie garantiert kostenfrei. Anschließend bieten wir Ihnen absolute Kostensicherheit und Transparenz: Wir informieren Sie vorab im Detail über die anstehenden Schritte und die damit verbundenen Kosten des Verfahrens und klären mit Ihnen die Kostenübernahme.'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
