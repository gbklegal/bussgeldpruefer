import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';
import '../constants.dart';

class AppVersion extends StatelessWidget {
  const AppVersion({key}) : super(key: key);

  _padding(double _height) {
    return SizedBox(height: _height);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/images/icons/bgpcaricon.png'),
              ),
              _padding(20.0),
              Text(
                'Die BussgeldPrüfer App ist aktualisiert worden.',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              _padding(20.0),
              Text(
                'Lade die neuste Version aus dem AppStore.',
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              _padding(20.0),
              ElevatedButton(
                  child: Text('Jetzt aktualisieren'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15.0),
                    minimumSize: Size(double.infinity, 30),
                    textStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    primary: kSecondaryColor,
                    onPrimary: Colors.white,
                  ),
                  onPressed: () {
                    LaunchReview.launch(
                        androidAppId: 'com.bussgeldpruefer.com',
                        iOSAppId: '1526662667');
                  })
            ],
          ),
        ),
      ),
    );
  }
}
