import 'package:app/functions/newscreen.dart';
import 'package:app/screens/profileinboxdetail.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/pagetitle.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class ProfileInboxScreen extends StatefulWidget {
  @override
  _ProfileInboxScreenState createState() => _ProfileInboxScreenState();
}

class _ProfileInboxScreenState extends State<ProfileInboxScreen> {
  int _currentScreen = 0;

  final List<Widget> screens = [
    ProfileInboxMainScreen(),
    ProfileInboxEditorScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      drawer: Drawer(
        child: Container(
          color: Colors.blue,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(
                height: 150,
                child: DrawerHeader(
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.white,
                        ),
                        child: Icon(
                          Icons.email_outlined,
                          color: Colors.blue,
                          size: 30,
                        ),
                      ),
                      _padding(10.0),
                      Text(
                        'Online Posteingang',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // _padding(0.0, 40.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: <Widget>[
                    TextButton(
                      onPressed: () => setState(() {
                        Navigator.pop(context);
                        _currentScreen = 0;
                      }),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Gerichtliche Angelegenheiten',
                          style: TextStyle(
                            color: (_currentScreen == 0)
                                ? Colors.blue.shade100
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                    _menuTextButton('Außergerichtliche Angelegenheiten'),
                    _menuTextButton('Sonstiges'),
                    _menuTextButton('Gesendet'),
                    TextButton(
                      onPressed: () => print(''),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.star_outline,
                            color: Colors.blue.shade100,
                          ),
                          _padding(5.0),
                          Text(
                            'Markiert',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => setState(() {
                        Navigator.pop(context);
                        _currentScreen = 1;
                      }),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                          _padding(5.0),
                          Text(
                            'schreiben',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
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
      ),
      body: screens[_currentScreen],
    );
  }
}

// Other screens

class ProfileInboxMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        _menuBurgerButton(),
        PageTitle('Mein Profil'),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _headerTitle(),
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
    );
  }
}

class ProfileInboxEditorScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Future formFeedback(BuildContext context) {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Danke Dir!'),
            content: Text('Deine Nachricht wurde versendet.'),
            actions: [
              TextButton(
                child: Text('schließen'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
    }

    return ListView(
      children: <Widget>[
        _menuBurgerButton(),
        PageTitle('Mein Profil'),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Column(
            children: <Widget>[
              _headerTitle(),
              _padding(),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Column(
                        children: <TextFormField>[
                          TextFormField(
                            keyboardType: TextInputType.text,
                            autocorrect: false,
                            decoration: InputDecoration(
                              labelText: 'An:',
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            autocorrect: false,
                            decoration: InputDecoration(
                              labelText: 'Von:',
                              hintText: 'Name des Mandaten',
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            autocorrect: false,
                            decoration: InputDecoration(
                              labelText: 'Betreff:',
                            ),
                          ),
                          TextFormField(
                            maxLines: 5,
                            maxLength: 120,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: 'Nachricht:',
                            ),
                          ),
                        ],
                      ),
                    ),
                    _padding(),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => formFeedback(context),
                        child: Text('senden'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Usefull functions

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
                children: <TableCell>[
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
                children: <TableCell>[
                  TableCell(
                    child: _padding(0.0, 10.0),
                  ),
                  TableCell(
                    child: _padding(0.0, 10.0),
                  ),
                ],
              ),
              TableRow(
                children: <TableCell>[
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

_menuTextButton(String text) {
  return TextButton(
    onPressed: () => print(''),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    ),
  );
}

_menuBurgerButton() {
  return Align(
    alignment: Alignment.centerLeft,
    child: Builder(
      builder: (context) => IconButton(
        icon: Icon(Icons.menu),
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
    ),
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
