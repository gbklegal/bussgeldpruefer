class VorNameValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return 'Bitte geben Sie den Vornamen ein';
    }
    if (value.length < 2) {
      return 'Der Name muss mindestens 2 Zeichen lang sein';
    }
    return null;
  }
}

class NachNameValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return 'Bitte geben Sie den Vornamen ein';
    }
    if (value.length < 2) {
      return 'Der Name muss mindestens 2 Zeichen lang sein';
    }
    return null;
  }
}

class EmailValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return 'Bitte geben Sie eine E-mail-Adresse ein';
    }
    return null;
  }
}

class PasswordValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return 'Passwort darf nicht leer sein';
    } else if (value.length < 6)
      return 'Ihr Passwort muss mindestens 6 Zeichen lang sein';
    return null;
  }
}
