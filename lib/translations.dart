import 'package:flutter/material.dart';

class Translations {
  static Translations? of(BuildContext context) {
    return Localizations.of<Translations>(context, Translations);
  }

  String get appName {
    return 'Calculator';
  }

  String get signIn {
    return 'Sign In';
  }

  String get signUp {
    return 'Sign Up';
  }

  String get calculator {
    return 'Calculator';
  }

  String get settings {
    return 'Settings';
  }

  String get help {
    return 'Help';
  }

  String get username {
    return 'Username';
  }

  String get email {
    return 'Email';
  }

  String get password {
    return 'Password';
  }

  String get switchToLightTheme {
    return 'Switch to Light Theme';
  }

  String get switchToDarkTheme {
    return 'Switch to Dark Theme';
  }

  String get helpContent {
    return 'Help content goes here.';
  }
}

class TranslationsDelegate extends LocalizationsDelegate<Translations> {
  const TranslationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'fr'].contains(locale.languageCode);

  @override
  Future<Translations> load(Locale locale) async {
    return Translations();
  }

  @override
  bool shouldReload(TranslationsDelegate old) => false;
}