import 'package:app/functions/newscreen.dart';
import 'package:app/screens/profileinboxdetail.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/pagetitle.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class ProfileInboxScreen extends StatelessWidget {
  _padding([width = 0.0, height = 20.0]) {
    return SizedBox(
      width: width,
      height: height,
    );
  }

  _inboxPreview(context, [bool unread = false]) {
    return Container(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () => newScreen(
              context: context,
              screen: ProfileInboxDetailScreen(),
            ),
            child: Table(
              columnWidths: const <int, TableColumnWidth>{
                1: IntrinsicColumnWidth(),
              },
              children: <TableRow>[
                TableRow(
                  children: [
                    TableCell(
                      child: Text(
                        'Diese Unterlagen fehlen',
                        style: TextStyle(
                          fontWeight:
                              unread ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                    TableCell(
                      child: Text(
                        '23.12.',
                        style: TextStyle(
                          fontWeight:
                              unread ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Text(
                        'Sehr geehrte Herr Xy, vielen Dank für Interesse. Bla',
                        style: TextStyle(
                          fontWeight:
                              unread ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                    TableCell(
                      child: Icon(
                        Icons.star_outline,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _padding(0.0, 10.0),
          Divider(
            color: Colors.black,
          ),
          _padding(0.0, 10.0),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Online Posteingang'),
            ),
            Text('Content'),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
          PageTitle('Mein Profil'),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
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
                ),
                _padding(),
                Row(
                  children: <Widget>[
                    Text('Gerichtliche Angelegenheit'),
                    _padding(5.0),
                    Badge(
                      badgeContent: Text(
                        '1',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                _padding(),
                _inboxPreview(context, true),
                _inboxPreview(context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
