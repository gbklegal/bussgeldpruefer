import 'package:app/functions/newscreen.dart';
import 'package:app/screens/contact.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/appbar.dart';
import '../widgets/pagetitle.dart';

import '../functions/newscreen.dart';

class InformationScreen extends StatelessWidget {
  _defaultText(text) {
    return Container(
      // color: Colors.grey.shade300,
      child: Text(
        text,
        style: TextStyle(fontSize: 15.0),
      ),
    );
  }

  _textPadding() {
    return SizedBox(height: 20.0);
  }

  _callPhoneNumber(phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _sendMail(mailAdress) async {
    final url = 'mailto:$mailAdress';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        isHome: false,
      ),
      body: ListView(
        children: [
          Column(
            children: [
              PageTitle('Information'),
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
                    _defaultText(
                        'BussgeldPrüfer ist ein Service der GDF GmbH. Dieser wird durch einen gemeinsamen Auftritt verschiedener Dienstleister realisiert. Mit der Nutzung der App „BussgeldPrüfer“ wirst Du an unsere Partnerkanzleien weitergeleitet, wenn Du deinen Bußgeldbescheid anwaltlich prüfen lassen willst. Unsere Partnerkanzleien vertreten Dich bei allen Bußgeldangelegenheiten im Verkehr (z.B. Geschwindigkeits-, Abstands-, Rotlicht-, Handy-, Park und Alkohol-/Drogenverstößen). Wenn Du eine Frage hast oder Hilfe benötigst melde Dich bei uns. Wir werden uns schnellstmöglichst bei Dir rückmelden. Die Erstberatung durch eine Partnerkanzlei ist in jedem Fall kostenlos.'),
                    _textPadding(),
                    _defaultText('Wie sind wir zu erreichen?'),
                    _textPadding(),
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: IconButton(
                              icon: Icon(Icons.phone),
                              onPressed: () =>
                                  _callPhoneNumber('+49911893103444'),
                              tooltip: 'Telefon',
                            ),
                          ),
                          Expanded(
                            child: IconButton(
                              icon: Icon(Icons.mail_outline),
                              onPressed: () =>
                                  _sendMail('dialog@bussgeldpruefer.com'),
                              tooltip: 'E-Mail',
                            ),
                          ),
                          Expanded(
                            child: IconButton(
                              icon: Icon(Icons.contact_support_outlined),
                              onPressed: () => newScreen(
                                screen: ContactScreen(),
                                context: context,
                              ),
                              tooltip: 'Kontaktformular',
                            ),
                          ),
                        ],
                      ),
                    ),
                    // _defaultText(
                    //     '1. Du kannst uns eine E-Mail schreiben an: dialog@bussgeldpruefer.com'),
                    // _textPadding(),
                    // _defaultText(
                    //     '2. Du kannst uns telefonisch unter +49 (0) 911 893103444 erreichen.'),
                    // _textPadding(),
                    // _defaultText(
                    //     '3. Du kannst unser Kontaktformular ausfüllen und wir melden uns bei Dir.'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
