import 'package:flutter/material.dart';

import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/pagetitle.dart';

import 'package:app/functions/newscreen.dart';

import 'package:app/screens/bussgeldkatalogdetail.dart';

class BussgeldkatalogScreen extends StatelessWidget {
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
    return Scaffold(
      appBar: AppBarWidget(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            PageTitle('Bußgeldkatalog',
                'In den unterschiedlichen Kategorien findest Du aktuelle Informationen zum Thema Verkehrsrecht. Es wird erklärt wann mit Bußgeldern, Punkten oder sogar Fahrverbot zu rechnen ist.'),
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
              child: Column(
                children: [
                  _simpleButton(
                    'In der 30er Zone geblitzt?',
                    context,
                    BussgeldkatalogDetailScreen(),
                  ),
                  _simpleButton('In der 30er Zone geblitzt?'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
