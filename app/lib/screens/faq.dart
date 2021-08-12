import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widgets/appbar.dart';
import '../widgets/pagetitle.dart';

class FaqScreen extends StatefulWidget {
  @override
  _FaqScreenState createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  Future _getFaqs() async {
    // ignore: todo
    // TODO: change url in prod.
    var response = await http
        .get(Uri.parse('https://xn--bussgeldprfer-5ob.com/bgp/faq.json'));
    // ignore: todo
    // TODO: check response status code
    return json.decode(utf8.decode(response.bodyBytes));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body:
          /*ListView(
        children: [
          Column(
            children: [
              PageTitle('FAQ', 'Häufig gestellte Fragen'),*/
          FutureBuilder(
        future: _getFaqs(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            // ignore: todo
            // TODO: fix pagetitle and listview
            return Column(
              children: <Widget>[
                PageTitle('FAQ', 'Häufig gestellte Fragen'),
                ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    String question = snapshot.data[index]['question'];
                    String answer = snapshot.data[index]['answer'];
                    return ExpansionTile(
                      title: Text(question),
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                          child: Text(answer),
                        ),
                      ],
                    );
                  },
                ),
              ],
            );
          }
        },
      ),
      /*],
          ),
        ],
      ),*/
    );
  }
}

// Future sendForm(String firstname) async {
//   final String apiUrl = 'https://dev02.gbk-rae.de/bgp/app/contactform.php';

//   final response = await http.post(apiUrl, body: {'firstname': firstname});
//   final statusCode = response.statusCode;

//   if (statusCode != 200) {
//     throw new Exception('Error while fetching data');
//   }

//   final data = json.decode(response.body);
//   print('sendmail: ' + data['sendmail'].toString());
// }
