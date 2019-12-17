import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class MtsLocalization
    extends LocalizationsDelegate<Map<dynamic, dynamic>> {
  static const List<String> supportedLanguages = [
    "bg",
    "de",
    "en",
    "es",
    "fr",
    "nl",
    "pl",
    "ru",
  ];

  @override
  bool isSupported(Locale locale) =>
      supportedLanguages.contains(locale.languageCode.toLowerCase());

  @override
  Future<Map<dynamic, dynamic>> load(Locale locale) async {
    String jsonContent = await rootBundle
        .loadString("assets/languages/${locale.languageCode}.json");
    return json.decode(jsonContent);
  }

  @override
  bool shouldReload(LocalizationsDelegate<Map<dynamic, dynamic>> old) {
    return false;
  }
}
