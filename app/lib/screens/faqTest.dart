import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FaqTestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Users'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future _getUsers() async {
    var response = await http.get('https://dev02.gbk-rae.de/bgp/app/faq.json');
    // TODO: check response status code
    return json.decode(utf8.decode(response.bodyBytes));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: FutureBuilder(
          future: _getUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  // String question = snapshot.data[index]['question'];
                  // String answer = snapshot.data[index]['answer'];
                  // return Text(answer);
                  return ExpansionTile(
                    title: Text(snapshot.data[index]['question']),
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                        child: Text(snapshot.data[index]['answer']),
                      ),
                    ],
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
