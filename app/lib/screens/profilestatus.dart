import 'package:app/functions/newscreen.dart';
import 'package:app/screens/contact.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/pagetitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

class ProfileStatusScreen extends StatefulWidget {
  @override
  _ProfileStatusScreenState createState() => _ProfileStatusScreenState();
}

class _ProfileStatusScreenState extends State<ProfileStatusScreen> {
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
            Icons.rotate_right_outlined,
            color: Colors.white,
            size: 30,
          ),
        ),
        _padding(10.0),
        Text(
          'Status Überprüfung',
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
              children: <Widget>[
                _headerTitle(),
                _padding(),
                // Expanded(
                //   child: Row(
                //     children: <Widget>[
                //       Flexible(
                //         child: FAProgressBar(
                //           currentValue: 40,
                //           progressColor: Colors.blue,
                //           direction: Axis.vertical,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // Expanded(
                //   child: FAProgressBar(
                //     currentValue: 40,
                //     progressColor: Colors.blue,
                //     // direction: Axis.vertical,
                //   ),
                // ),

                Text(
                    'Du hast Fragen zu deinem Status? Dann kontaktiere uns. Wir werden uns schnellstmöglich darum kümmern.'),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => newScreen(
                      context: context,
                      screen: ContactScreen(),
                    ),
                    child: Text('Kontakt'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
