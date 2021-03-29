import 'package:flutter/material.dart';

import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/pagetitle.dart';

class BussgeldkatalogDetailScreen extends StatelessWidget {
  // final String description;

  // BussgeldkatalogDetailScreen(this.description);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            PageTitle('Bußgeldkatalog', 'In der 30er Zone geblitzt?'),
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
              child: Text(
                  'Die Tempo 30er Zone erfüllt drei grundlegende Funktionen. So soll die 30-Zone die Verkehrssicherheit erhöhen. Aufgrund eines Verkehrssicherheitsprogrammes führte Berlin vor fast allen Schulen und Kitas die 30er Zone ein.'),
            ),
          ],
        ),
      ),
    );
  }
}
