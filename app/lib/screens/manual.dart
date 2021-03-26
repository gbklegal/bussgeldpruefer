import 'package:app/widgets/circlenumber.dart';
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
                            CircleNumber('1'),
                            _text(
                              'Mit Hilfe des Quick-Checks erhältst Du eine unverbindliche Ersteinschätzung deines Falls.',
                            ),
                          ],
                        ),
                        _hr(),
                        Row(
                          children: [
                            CircleNumber('2'),
                            _text(
                              'Mit Hilfe des Quick-Checks erhältst Du eine unverbindliche Ersteinschätzung deines Falls.',
                            ),
                          ],
                        ),
                        _hr(),
                        Row(
                          children: [
                            CircleNumber('3'),
                            _text(
                              'Mit Hilfe des Quick-Checks erhältst Du eine unverbindliche Ersteinschätzung deines Falls.',
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
