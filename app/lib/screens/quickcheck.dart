import 'package:app/global.dart';
import 'package:app/utilities/quickcheck.dart';
import 'package:app/functions/newscreen.dart';
import 'package:app/screens/quickcheckfinal.dart';
import 'package:app/widgets/pagetitle.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class QuickCheckScreen extends StatefulWidget {
  QuickCheckScreen({Key key}) : super(key: key);

  @override
  _QuickCheckScreenState createState() => _QuickCheckScreenState();
}

class _QuickCheckScreenState extends State<QuickCheckScreen> {
  final dateController = TextEditingController();
  var letterReceived = DateTime.now();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed
    dateController.dispose();
    super.dispose();
  }

  _title(text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 22.0,
      ),
    );
  }

  _padding() {
    return SizedBox(height: 20.0);
  }

  double _demoPadding = 10.0;

  _demoBlockPadding(direction) {
    if (direction == 'width') {
      return SizedBox(width: _demoPadding);
    }
    return SizedBox(height: _demoPadding);
  }

  _demoBlock() {
    return Container(
      width: (MediaQuery.of(context).size.width * 0.5) - 25,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        color: Colors.grey.shade300,
      ),
    );
  }

  SelbstGefahren _selbstGefahren;
  SelbstGefahrenZugegeben _selbstGefahrenZugegeben;
  VerstossZugegeben _verstossZugegeben;
  VerstossBezahlt _verstossBezahlt;
  AngabenRichtig _angabenRichtig;
  Rechtsschutzversicherung _rechtsschutzversicherung;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: <Widget>[
          PageTitle(
            'Quick Check',
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              20.0,
              0.0,
              20.0,
              40.0,
            ),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _title('1. Wähle Deinen Verstoß aus'),
                  Column(
                    children: <Widget>[
                      _demoBlockPadding('height'),
                      Row(
                        children: <Widget>[
                          _demoBlock(),
                          _demoBlockPadding('width'),
                          _demoBlock()
                        ],
                      ),
                      _demoBlockPadding('height'),
                      Row(
                        children: <Widget>[
                          _demoBlock(),
                          _demoBlockPadding('width'),
                          _demoBlock()
                        ],
                      ),
                      _demoBlockPadding('height'),
                      Row(
                        children: <Widget>[
                          _demoBlock(),
                          _demoBlockPadding('width'),
                          _demoBlock()
                        ],
                      ),
                    ],
                  ),
                  _padding(),
                  _title('2. Bist Du selbst gefahren?'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(children: [
                        Text('Ja'),
                        Radio<SelbstGefahren>(
                          value: SelbstGefahren.ja,
                          groupValue: _selbstGefahren,
                          onChanged: (SelbstGefahren value) {
                            setState(() => _selbstGefahren = value);
                          },
                        ),
                      ]),
                      Row(
                        children: [
                          Text('Nein'),
                          Radio<SelbstGefahren>(
                            value: SelbstGefahren.nein,
                            groupValue: _selbstGefahren,
                            onChanged: (SelbstGefahren value) {
                              setState(() => _selbstGefahren = value);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  _padding(),
                  _title(
                      'Hast du bereits Zugegeben, dass du selbst gefahren bist?'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(children: [
                        Text('Ja'),
                        Radio<SelbstGefahrenZugegeben>(
                          value: SelbstGefahrenZugegeben.ja,
                          groupValue: _selbstGefahrenZugegeben,
                          onChanged: (SelbstGefahrenZugegeben value) {
                            setState(() => _selbstGefahrenZugegeben = value);
                          },
                        ),
                      ]),
                      Row(
                        children: [
                          Text('Nein'),
                          Radio<SelbstGefahrenZugegeben>(
                            value: SelbstGefahrenZugegeben.nein,
                            groupValue: _selbstGefahrenZugegeben,
                            onChanged: (SelbstGefahrenZugegeben value) {
                              setState(() => _selbstGefahrenZugegeben = value);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  _padding(),
                  _title('Hast Du den Verstoß bereits zugegeben?'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(children: [
                        Text('Ja'),
                        Radio<VerstossZugegeben>(
                          value: VerstossZugegeben.ja,
                          groupValue: _verstossZugegeben,
                          onChanged: (VerstossZugegeben value) {
                            setState(() => _verstossZugegeben = value);
                          },
                        ),
                      ]),
                      Row(
                        children: [
                          Text('Nein'),
                          Radio<VerstossZugegeben>(
                            value: VerstossZugegeben.nein,
                            groupValue: _verstossZugegeben,
                            onChanged: (VerstossZugegeben value) {
                              setState(() => _verstossZugegeben = value);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  _padding(),
                  _title('Hast Du den Verstroß bereits bezahlt?'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(children: [
                        Text('Ja'),
                        Radio<VerstossBezahlt>(
                          value: VerstossBezahlt.ja,
                          groupValue: _verstossBezahlt,
                          onChanged: (VerstossBezahlt value) {
                            setState(() => _verstossBezahlt = value);
                          },
                        ),
                      ]),
                      Row(
                        children: [
                          Text('Nein'),
                          Radio<VerstossBezahlt>(
                            value: VerstossBezahlt.nein,
                            groupValue: _verstossBezahlt,
                            onChanged: (VerstossBezahlt value) {
                              setState(() => _verstossBezahlt = value);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  _padding(),
                  _title(
                      'Welches Anschreiben (Brief) hast Du zuletzt bekommen?'),
                  Align(
                    alignment: Alignment.center,
                    child: DropdownButton<String>(
                      value: quickCheckLastOfficialLetter,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      underline: Container(
                        height: 2,
                        color: Colors.blue,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          quickCheckLastOfficialLetter = newValue;
                        });
                      },
                      items: <String>[
                        'Anhörungsbogen',
                        'Bußgeldbescheid',
                        'Strafbefehl',
                        'Zeugenanhörungsbogen',
                        'noch keines',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  _padding(),
                  _title(
                      'Stimmen die Angaben im Anschreiben aus Deiner Sicht?'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(children: [
                        Text('Ja'),
                        Radio<AngabenRichtig>(
                          value: AngabenRichtig.ja,
                          groupValue: _angabenRichtig,
                          onChanged: (AngabenRichtig value) {
                            setState(() => _angabenRichtig = value);
                          },
                        ),
                      ]),
                      Row(
                        children: [
                          Text('Nein'),
                          Radio<AngabenRichtig>(
                            value: AngabenRichtig.nein,
                            groupValue: _angabenRichtig,
                            onChanged: (AngabenRichtig value) {
                              setState(() => _angabenRichtig = value);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  _padding(),
                  _title('Besitzt Du eine Rechtsschutzversicherung?'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(children: [
                        Text('Ja'),
                        Radio<Rechtsschutzversicherung>(
                          value: Rechtsschutzversicherung.ja,
                          groupValue: _rechtsschutzversicherung,
                          onChanged: (Rechtsschutzversicherung value) {
                            setState(() => _rechtsschutzversicherung = value);
                          },
                        ),
                      ]),
                      Row(
                        children: [
                          Text('Nein'),
                          Radio<Rechtsschutzversicherung>(
                            value: Rechtsschutzversicherung.nein,
                            groupValue: _rechtsschutzversicherung,
                            onChanged: (Rechtsschutzversicherung value) {
                              setState(() => _rechtsschutzversicherung = value);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  _padding(),
                  _title(
                      'Wann haben Sie das letzte behödrliche Schreiben erhalten?'),
                  TextField(
                    readOnly: true,
                    controller: dateController,
                    decoration: InputDecoration(hintText: 'Datum auswählen'),
                    onTap: () async {
                      var date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(DateTime.now().year - 1),
                        lastDate: DateTime(DateTime.now().year + 1),
                        locale: Locale('de'),
                      );
                      letterReceived =
                          DateTime.utc(date.year, date.month, date.day);
                      dateController.text =
                          DateFormat('dd.MM.yyyy').format(date).toString();
                    },
                  ),
                  _padding(),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: () => print('previous'),
                            ),
                            Text('zurück'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.refresh),
                              onPressed: () => print('restart'),
                            ),
                            Text('neu starten'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.arrow_forward),
                              onPressed: () {
                                // TODO: check if the radio buttons are not empty, if so: display alert and list what is missing
                                // save traffic light color into the global variable
                                quickCheckTrafficLightColor =
                                    quickCheckValidation(
                                  violationAdmitted: _verstossZugegeben ==
                                      VerstossZugegeben.ja,
                                  violationPayed:
                                      _verstossBezahlt == VerstossBezahlt.ja,
                                  selfDriven:
                                      _selbstGefahren == SelbstGefahren.ja,
                                  selfDrivenAdmitted:
                                      _selbstGefahrenZugegeben ==
                                          SelbstGefahrenZugegeben.ja,
                                  detailsCorrect:
                                      _angabenRichtig == AngabenRichtig.ja,
                                  letterReceived: letterReceived,
                                );
                                // return the score to the next screen
                                newScreen(
                                  context: context,
                                  screen: QuickCheckFinalScreen(
                                      quickCheckTrafficLightColor), // add score as a parameter
                                );
                              },
                            ),
                            Text('weiter'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum SelbstGefahren { ja, nein }
enum SelbstGefahrenZugegeben { ja, nein }
enum VerstossZugegeben { ja, nein }
enum VerstossBezahlt { ja, nein }
enum AngabenRichtig { ja, nein }
enum Rechtsschutzversicherung { ja, nein }
