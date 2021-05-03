import 'dart:convert';

import 'package:app/functions/webview.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class DummyScreen extends StatefulWidget {
  @override
  _DummyScreenState createState() => _DummyScreenState();
}

Future sendForm(String firstname) async {
  final String apiUrl = 'https://dev02.gbk-rae.de/bgp/app/contactform.php';

  final response = await http.post(apiUrl, body: {'firstname': firstname});
  final statusCode = response.statusCode;

  if (statusCode != 200) {
    throw new Exception('Error while fetching data');
  }

  final data = json.decode(response.body);
  print('sendmail: ' + data['sendmail'].toString());
}

// Future createPost(String url, {Map body}) async {
//   return http.post(url, body: body).then((http.Response response) {
//     final int statusCode = response.statusCode;

//     if (statusCode < 200 || statusCode > 400 || json == null) {
//       throw new Exception("Error while fetching data");
//     }
//     return Post.fromJson(json.decode(response.body));
//   });
// }

class _DummyScreenState extends State<DummyScreen> {
  final _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    super.dispose();
  }

  _padding() {
    return SizedBox(height: 20.0);
  }

  _image(name) {
    return Image.asset(
      name,
      width: 184,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dummy Screen'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text('Menü Header'),
            )
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text('Öffne WebView'),
                    onPressed: () {
                      webView(
                        context: context,
                        title: 'Bußgeld Ratgeber',
                        url:
                            'https://xn--bussgeldprfer-5ob.com/ratgeber/?app_mode',
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.close),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
