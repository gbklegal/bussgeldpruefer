import 'package:app/constants.dart';
import 'package:app/global.dart';
import 'package:app/screens/ablauf.dart';
import 'package:app/screens/bussgeldkatalog.dart';
import 'package:app/screens/bussgeldratgeber.dart';
import 'package:app/screens/infokanzlei.dart';
import 'package:app/screens/manual.dart';
import 'package:app/screens/pruefungbussgeldbescheid.dart';
import 'package:app/services/connectivity.dart';
import 'package:app/widgets/bigbuttonwidget.dart';
import 'package:flutter/material.dart';

import 'package:app/functions/newscreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _title(text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 32,
      ),
    );
  }

  _padding() {
    return SizedBox(height: 12.0);
  }

  _simpleButton(text, [context, screen]) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => {
          if (context == null || screen == null)
            {print('_simpleButton() pressed')}
          else
            {
              newScreen(
                context: context,
                screen: screen,
              )
            }
        },
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(text),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _title('Fall-Prüfung'),
                      _padding(),
                      BigButtonWidget(
                        title: 'Quick Check',
                        text:
                            'Kostenlose Ersteinschätzung in 90 Sekunden - ganz unverbindlich',
                        image: 'assets/images/icons/fast-time.png',
                      ),
                      _padding(),
                      BigButtonWidget(
                        title: 'Prüfung Bußgeldbescheid',
                        text:
                            'Unverbindliche Prüfung durch Anwalt - Antwort in 24 Stunden',
                        screen: PruefungBussgeldbescheidScreen(),
                        index: 1,
                      ),
                      _padding(),
                      BigButtonWidget(
                        title: 'Bußgeldbescheid erhalten?',
                        text:
                            'So gehst du vor, um erfolgreich Einspruch einzulegen',
                        screen: AblaufScreen(),
                      ),
                      _padding(),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _title('Hinweise'),
                      _padding(),
                      _simpleButton(
                          'Bußgeldkatalog', context, BussgeldkatalogScreen()),
                      _simpleButton(
                        'Bußgeld Ratgeber',
                        context,
                        BussgeldratgeberScreen(),
                      ),
                      _simpleButton(
                        'Anleitung',
                        context,
                        ManualScreen(),
                      ),
                      _simpleButton(
                        'Deine Experten Im Verkehrsrecht',
                        context,
                        InfoKanzleiScreen(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
