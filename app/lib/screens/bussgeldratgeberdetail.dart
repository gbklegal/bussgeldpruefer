import 'package:app/models/post.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/pagetitle.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class BussgeldRatgeberDetailScreen extends StatelessWidget {
  final Post post;
  final f = new DateFormat('dd-MM-yyyy hh:mm');

  BussgeldRatgeberDetailScreen(this.post);

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
            PageTitle('Bußgeld Ratgeber', post.title.rendered),
            Container(
              padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
              child: Column(
                children: [
                  Container(
                    child: FadeInImage.assetNetwork(
                      placeholder: "assets/loading.gif",
                      image: post.embedded.wpFeaturedmedia[0].sourceUrl,
                      fit: BoxFit.contain,
                    ),
                    height: 200.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      //color: Colors.grey.shade300,
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                  _padding(),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(f.format(post.date)),
                  ),
                  _padding(),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Author: " + post.embedded.author[0].name),
                  ),
                  _padding(),
                  HtmlWidget(
                    post.content.rendered,
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
