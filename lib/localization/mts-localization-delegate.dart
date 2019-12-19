import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/localization/translation.dart';
import 'package:flutter/services.dart' show rootBundle;

class MtsLocalizationDelegate extends LocalizationsDelegate<Translation> {
  static const List<String> supportedLanguages = [
    "en",
    "de",
    "bg",
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
  Future<Translation> load(Locale locale) async {
    Map<dynamic, dynamic> translationMap = await _loadFromAssets(locale);
    return Translation(locale, translationMap);
  }

  @override
  bool shouldReload(LocalizationsDelegate<Translation> old) => false;

  static Future<Map<dynamic, dynamic>> _loadFromAssets(Locale locale) async {
    String jsonContent = await rootBundle
        .loadString("assets/languages/${locale.languageCode}.json");

    return json.decode(jsonContent);
  }
}
