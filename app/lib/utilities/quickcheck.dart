void main() {
  // Verstoß
  String violation = '';
  // Behördenschreiben
  String lastLetter = '';
  // Rechtschutzversicherung
  String insurance = '';
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

  int score = 0;
  // var _21days = 1000 * 60 * 24 * 21; // millisecond * seconds * hours * days
  var letterReceived = DateTime.utc(2021, 4, 9);
  var now = DateTime.now();

  if (violation != '') score++;
  if (lastLetter != '') score++;
  if (insurance != '') score++;
  now.difference(letterReceived).inDays < 21 ? score++ : score--;
  violationAdmitted ? score-- : score++;
  violationPayed ? score-- : score++;
  selfDriven ? score-- : score++;
  selfDrivenAdmitted ? score-- : score++;
  detailsCorrect ? score++ : score--;

  print(score);
}
