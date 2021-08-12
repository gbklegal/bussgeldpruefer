import 'package:app/global.dart';
import 'package:app/utilities/quickcheck.dart';
import 'package:app/functions/newscreen.dart';
import 'package:app/screens/quickcheckfinal.dart';
import 'package:app/widgets/pagetitle.dart';
import 'package:bordered_text/bordered_text.dart';
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
  var lastOfficialLetterItems = <String>[
    'Anhörungsbogen',
    'Bußgeldbescheid',
    'Strafbefehl',
    'Zeugenanhörungsbogen',
    'noch keines',
  ];
  bool hideDatePicker = false;

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

  List<String> violationImageNames = [
    'speed',
    'redlight',
    'distance',
    'alcohol',
    'phone',
    'parking'
  ];
  List<String> violationNames = [
    'Geschwindig\u2011\nkeit',
    'Rote Ampel',
    'Abstand',
    'Alkohol',
    'Telefon',
    'Falschparken'
  ];
  int selectedViolationIndex;

  void changeViolationIndex(int index) {
    setState(() => selectedViolationIndex = index);
  }

  Widget customImageRadio(String image, String name, int index) {
    return GestureDetector(
      onTap: () => changeViolationIndex(index),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 10,
            color: (index == selectedViolationIndex)
                ? Color(0xff5CC8C5)
                : Colors.transparent,
          ),
        ),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            Image.asset('assets/images/$image.jpg'),
            BorderedText(
              strokeColor: Colors.black,
              strokeWidth: 3,
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future alertDialog(BuildContext context, String text) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hinweis!'),
          content: Text(text),
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

  Future confirmResetDialog(BuildContext context, String question) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Bist Du sicher?'),
            content: Text(question),
            actions: [
              TextButton(
                child: Text('Ja'),
                onPressed: () {
                  _resetQuickCheck();
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text('Nein'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }

  _resetQuickCheck() {
    setState(() {
      selectedViolationIndex = null;
      _selbstGefahren = null;
      _selbstGefahrenZugegeben = null;
      _verstossZugegeben = null;
      _verstossBezahlt = null;
      _angabenRichtig = null;
      _rechtsschutzversicherung = null;
      letterReceived = null;
      dateController.clear();
    });
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
                  _title('1. Wähle Deinen Verstoß aus:'),
                  Column(
                    children: <Widget>[
                      _padding(),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: customImageRadio(
                                violationImageNames[0], violationNames[0], 0),
                          ),
                          Expanded(
                            child: customImageRadio(
                                violationImageNames[1], violationNames[1], 1),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: customImageRadio(
                                violationImageNames[2], violationNames[2], 2),
                          ),
                          Expanded(
                            child: customImageRadio(
                                violationImageNames[3], violationNames[3], 3),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: customImageRadio(
                                violationImageNames[4], violationNames[4], 4),
                          ),
                          Expanded(
                            child: customImageRadio(
                                violationImageNames[5], violationNames[5], 5),
                          ),
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
                        color: Color(0xff183B63),
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          if (newValue == 'noch keines')
                            hideDatePicker = true;
                          else
                            hideDatePicker = false;
                          quickCheckLastOfficialLetter = newValue;
                        });
                      },
                      items: lastOfficialLetterItems
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  if (!hideDatePicker) _padding(),
                  if (!hideDatePicker)
                    _title(
                        'Wann haben Sie das letzte behördliche Schreiben erhalten?'),
                  if (!hideDatePicker)
                    TextField(
                      readOnly: true,
                      controller: dateController,
                      decoration: InputDecoration(hintText: 'Datum auswählen'),
                      onTap: () async {
                        var date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(DateTime.now().year - 1),
                          // lastDate: DateTime(DateTime.now().year + 1),
                          lastDate: DateTime.now(),
                          locale: Locale('de'),
                        );
                        letterReceived =
                            DateTime.utc(date.year, date.month, date.day);
                        dateController.text =
                            DateFormat('dd.MM.yyyy').format(date).toString();
                      },
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
                  Row(
                    children: [
                      Expanded(
                        child: Placeholder(
                          fallbackWidth: 30,
                          fallbackHeight: 30,
                          color: Colors.transparent,
                        ),
                        /* Column(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: () => print('previous'),
                            ),
                            Text('zurück'),
                          ],
                        ),*/
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.refresh),
                              onPressed: () => confirmResetDialog(context,
                                  'Möchtest du den Quick Check zurücksetzten?'),
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
                                String missingSelectionText = '';

                                if (selectedViolationIndex == null)
                                  missingSelectionText +=
                                      '\n- Wähle deinen Verstoß aus';
                                if (_selbstGefahren == null)
                                  missingSelectionText +=
                                      '\n- Bist Du selbst gefahren?';
                                if (_selbstGefahrenZugegeben == null)
                                  missingSelectionText +=
                                      '\n- Hast Du bereits Zugegeben, dass du selbst gefahren bist?';
                                if (_verstossZugegeben == null)
                                  missingSelectionText +=
                                      '\n- Hast Du den Verstoß bereits zugeben?';
                                if (_verstossBezahlt == null)
                                  missingSelectionText +=
                                      '\n- Hast Du den Verstoß bereits bezahlt?';
                                if (!hideDatePicker &&
                                    dateController.text == '')
                                  missingSelectionText +=
                                      '\n- Wann haben Sie das behördliche Schreiben erhalten?';
                                if (_angabenRichtig == null)
                                  missingSelectionText +=
                                      '\n- Stimmen die Angaben im Anschreiben aus Deiner Sicht?';
                                if (_rechtsschutzversicherung == null)
                                  missingSelectionText +=
                                      '\n- Besitzt Du eine Rechtsschutzversicherung?';

                                if (missingSelectionText != '') {
                                  alertDialog(context,
                                      'Folgende Angaben fehlen noch:\n$missingSelectionText');
                                } else {
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
                                  quickCheckViolationName =
                                      violationNames[selectedViolationIndex]
                                          .replaceAll('\u2011\n', '');
                                  quickCheckViolationIndex =
                                      selectedViolationIndex;
                                  // reset the quick check inputs
                                  _resetQuickCheck();
                                  // return the score to the next screen
                                  newScreen(
                                    context: context,
                                    screen: QuickCheckFinalScreen(
                                        violationName: quickCheckViolationName,
                                        trafficLightColor:
                                            quickCheckTrafficLightColor), // add score as a parameter
                                  );
                                }
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
