import 'package:flutter/material.dart';

import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/pagetitle.dart';

import 'package:app/functions/newscreen.dart';

import 'package:app/screens/bussgeldratgeberdetail.dart';

class BussgeldratgeberScreen extends StatelessWidget {
  _imageButton(text, [context, screen]) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(padding: EdgeInsets.all(15.0)),
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
        child: Column(
          children: [
            Container(
              height: 140.0,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
            ),
            SizedBox(height: 8.0),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(text),
            ),
          ],
        ),
      ),
    );
  }

  _padding() {
    return SizedBox(height: 20.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            PageTitle('Bußgeld Ratgeber',
                'In unserem Bußgeld Ratgeber findest du aktuelle Bußgelder, Punkte & Fahrverbote. Hier kannst Du Dich über Bußgelder im Straßenverkehr informieren.'),
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
              child: Column(
                children: [
                  _imageButton(
                    'In der 30er Zone geblitzt?',
                    context,
                    BussgeldRatgeberDetailScreen('In der 30er Zone geblitzt?'),
                  ),
                  _padding(),
                  _imageButton('In der 30er Zone geblitzt?'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
