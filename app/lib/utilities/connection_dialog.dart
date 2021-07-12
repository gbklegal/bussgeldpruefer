import 'package:flutter/material.dart';
import 'package:open_settings/open_settings.dart';

class ConnectionDialog {
  showAlertDialog(BuildContext context, String title, String content) {
    // set up the button
    Widget okButton = ElevatedButton(
      child: Text("OK"),
      onPressed: () async {
        Navigator.pop(context);
      },
    );

    Widget settingButton = ElevatedButton(
      child: Text("Gehe zu den Einstellungen"),
      onPressed: () async {
        OpenSettings.openWIFISetting();
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        settingButton,
        okButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
