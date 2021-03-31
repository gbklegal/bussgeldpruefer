import 'package:flutter/material.dart';

import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/pagetitle.dart';

class BussgeldRatgeberDetailScreen extends StatelessWidget {
  final String description;

  BussgeldRatgeberDetailScreen(this.description);

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
            PageTitle('Bußgeld Ratgeber', description),
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
              child: Column(
                children: [
                  Container(
                    height: 170.0,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                  _padding(),
                  Text(
                      'Die Tempo 30er Zone erfüllt drei grundlegende Funktionen. So soll die 30-Zone die Verkehrssicherheit erhöhen. Aufgrund eines Verkehrssicherheitsprogrammes führte Berlin vor fast allen Schulen und Kitas die 30er Zone ein.'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
