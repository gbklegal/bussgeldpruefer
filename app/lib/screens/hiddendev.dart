import 'package:app/functions/newscreen.dart';
import 'package:app/functions/webview.dart';
import 'package:app/screens/ablauf.dart';
import 'package:app/screens/bussgeldkatalog.dart';
import 'package:app/screens/bussgeldkatalogdetail.dart';
import 'package:app/screens/bussgeldratgeber.dart';
import 'package:app/screens/bussgeldratgeberdetail.dart';
import 'package:app/screens/contact.dart';
import 'package:app/screens/contactfeedback.dart';
import 'package:app/screens/dummy.dart';
import 'package:app/screens/faq.dart';
import 'package:app/screens/infokanzlei.dart';
import 'package:app/screens/information.dart';
import 'package:app/screens/manual.dart';
import 'package:app/screens/profile.dart';
import 'package:app/screens/quickcheck.dart';
import 'package:app/screens/quickcheckfinal.dart';
import 'package:app/widgets/appbar.dart';
import 'package:flutter/material.dart';

import '../global.dart';

class HiddenDevScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _simpleButton(text, screen) {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => newScreen(context: context, screen: screen),
          child: Text(text),
        ),
      );
    }

    _padding() {
      return SizedBox(height: 20);
    }

    Future<String> createAlertDialog(BuildContext context) {
      TextEditingController customController = TextEditingController();

      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Gib eine URL ein:'),
            content: TextField(
              keyboardType: TextInputType.url,
              autocorrect: false,
              controller: customController,
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text('Submit'),
                onPressed: () => Navigator.pop(
                  context,
                  customController.text.toString(),
                ),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBarWidget(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                'Willkommen beim HDS (Hidden Dev Screen)',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 20.0),
              _simpleButton('Ablauf', AblaufScreen()),
              _simpleButton('Bußgeldkatalog', BussgeldkatalogScreen()),
              _simpleButton(
                  'Bußgeldkatalog Detail', BussgeldkatalogDetailScreen()),
              _simpleButton('Bußgeld Ratgeber', BussgeldratgeberScreen()),
              _simpleButton('Bußgeld Ratgeber Detail',
                  BussgeldRatgeberDetailScreen('empty string [HDS]')),
              _simpleButton('Kontakt', ContactScreen()),
              _simpleButton('Kontakt Feedback', ContactFeedbackScreen()),
              _simpleButton('Dummy', DummyScreen()),
              _simpleButton('FAQ', FaqScreen()),
              _simpleButton('Info Kanzlei', InfoKanzleiScreen()),
              _simpleButton('Information', InformationScreen()),
              _simpleButton('Anleitung', ManualScreen()),
              _simpleButton('Profil', ProfileScreen()),
              _simpleButton('Quick Check', QuickCheckScreen()),
              _simpleButton(
                  'Quick Check Final', QuickCheckFinalScreen('green')),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => createAlertDialog(context).then((onValue) {
                    webView(
                      context: context,
                      url: onValue,
                    );
                  }),
                  child: Text('WebView'),
                ),
              ),
              _padding(),
              Text(
                  'quickCheckLastOfficialLetter: $quickCheckLastOfficialLetter'),
              Text('quickCheckTrafficLightColor: $quickCheckTrafficLightColor'),
              _padding(),
            ],
          ),
        ),
      ),
    );
  }
}
