import 'package:app/models/docs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:intl/intl.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/pagetitle.dart';

class BussgeldkatalogDetailScreen extends StatelessWidget {
  final Docs docs;
  final f = new DateFormat('dd.MM.yyyy - hh:mm');

  BussgeldkatalogDetailScreen(this.docs);

  _padding() {
    return SizedBox(height: 20.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PageTitle('Bußgeldkatalog', docs.title.rendered),
            Container(
              padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(f.format(docs.date)),
                  ),
                  _padding(),
                  HtmlWidget(
                    docs.content.rendered,
                    textStyle: TextStyle(fontSize: 13),
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
