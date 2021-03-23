import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  final String title;
  final String description;

  PageTitle(this.title, [this.description = '']);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          // color: Colors.black12,
          ),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              this.title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (this.description != '')
              Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  this.description,
                  textAlign: TextAlign.left,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
