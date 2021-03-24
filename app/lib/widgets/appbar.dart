import 'package:app/screens/information.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  final isHome;

  AppBarWidget({this.isHome = true});

  _leadingContent(context) {
    if (isHome) {
      return Text('');
    }
    return IconButton(
      icon: Icon(
        Icons.arrow_back_outlined,
        color: Colors.black,
      ),
      onPressed: () => Navigator.pop(context),
    );
  }

  _actionsContent(context) {
    if (!isHome) {
      return <Widget>[];
    }
    return <Widget>[
      IconButton(
        icon: Icon(
          Icons.help_outline,
          color: Colors.black,
        ),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => InformationScreen()),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: _leadingContent(context),
      title: Image.asset(
        'assets/logo/BussgeldPruefer-Logo-small.png',
        height: 30,
        fit: BoxFit.cover,
      ),
      actions: _actionsContent(context),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
