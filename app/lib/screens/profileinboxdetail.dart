import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/pagetitle.dart';
import 'package:flutter/material.dart';

class ProfileInboxDetailScreen extends StatelessWidget {
  _padding([width = 0.0, height = 20.0]) {
    return SizedBox(
      width: width,
      height: height,
    );
  }

  _headerTitle() {
    return Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.blue,
          ),
          child: Icon(
            Icons.email_outlined,
            color: Colors.white,
            size: 30,
          ),
        ),
        _padding(10.0),
        Text(
          'Online Posteingang',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: ListView(
        children: <Widget>[
          PageTitle('Mein Profil'),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _headerTitle(),
                _padding(),
                Text('Gerichtliche Angelegenheit'),
                _padding(),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text('Diese Unterlagen fehlen'),
                    ),
                    Text('23.12.'),
                    _padding(10.0, 0.0),
                    Icon(Icons.star_outline),
                  ],
                ),
                _padding(),
                Text(
                    'Sehr geehrte Herr Xy,\n\nvielen Dank für Interesse. Blakdfjsdfsdkfjsdklfhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhs#ödffsd#'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
