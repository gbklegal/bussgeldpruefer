void main() {
  // Verstoß
  // String violation = '';
  // Behördenschreiben
  // String lastLetter = '';
  // Rechtschutzversicherung
  // String insurance = '';
  // Verstoß bereits zugegeben
  bool violationAdmitted = false;
  // Verstoß bereits bezahlt
  bool violationPayed = false;
  // selbst gefahren
  bool selfDriven = false;
  // selbst gefahren zugegeben
  bool selfDrivenAdmitted = false;
  // stimmen die Angaben
  bool detailsCorrect = false;

  // Ampel
  String trafficLightColor = 'rot';

  int score = 0;
  var letterReceived = DateTime.utc(2021, 4, 9);
  var now = DateTime.now();
  var letterReceivedDifference = now.difference(letterReceived).inDays;

  // score counter
  if (letterReceivedDifference > 21) score++;
  if (violationAdmitted) score++;
  if (violationPayed) score++;
  if (selfDriven) score++;
  if (selfDrivenAdmitted) score++;
  if (detailsCorrect) score++;

  // evaluation
  if (score == 0)
    trafficLightColor = 'grün';
  else if (score > 0 && score < 6) trafficLightColor = 'gelb';

  // print the result
  print('Score ($score): $trafficLightColor');
}

quickCheckValidation({
  bool violationAdmitted,
  bool violationPayed,
  bool selfDriven,
  bool selfDrivenAdmitted,
  bool detailsCorrect,
  DateTime letterReceived,
}) {
  print('Hey');
  return 'Hey';
}
