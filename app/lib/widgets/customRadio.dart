import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Title',
      home: CustomRadioScreen(),
    );
  }
}

class CustomRadioScreen extends StatefulWidget {
  @override
  _CustomRadioScreenState createState() => _CustomRadioScreenState();
}

class _CustomRadioScreenState extends State<CustomRadioScreen> {
  List<String> lst = ['Abstand', 'Geschwindigkeit', 'Rote Ampel'];
  int selectedIndex = 0;

  void changeIndex(int index) {
    setState(() => selectedIndex = index);
  }

  Widget customRadio(String txt, int index) {
    return OutlinedButton(
      onPressed: () => changeIndex(index),
      child: Text(txt,
          style: TextStyle(
              color: selectedIndex == index ? Colors.cyan : Colors.grey)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Radio Button'),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                customRadio(lst[0], 0),
                SizedBox(
                  height: 30.0,
                ),
                customRadio(lst[1], 1),
                SizedBox(
                  height: 30.0,
                ),
                customRadio(lst[2], 2),
                SizedBox(
                  height: 30.0,
                ),
                ElevatedButton(
                  onPressed: () => print(lst[selectedIndex]),
                  child: Text('Get selected Item'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DatePicker extends StatefulWidget {
  // DatePicker({Key key}) : super(key: key);

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  final dateController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
          child: TextField(
        readOnly: true,
        controller: dateController,
        decoration: InputDecoration(hintText: 'Pick your Date'),
        onTap: () async {
          var date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100));
          dateController.text = date.toString().substring(0, 10);
        },
      )),
    );
  }
}
