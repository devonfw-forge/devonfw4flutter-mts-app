import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class MtsLocalizationDelegate extends LocalizationsDelegate<Translation> {
  static const List<String> supportedLanguages = [
    'en',
    'de',
    'bg',
    'es',
    'fr',
    'nl',
    'pl',
    'ru',
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
        .loadString('assets/languages/${locale.languageCode}.json');

    return json.decode(jsonContent);
  }
}

@immutable
class Translation {
  final Locale locale;
  final Map<dynamic, dynamic> _translationMap;

  const Translation(this.locale, this._translationMap);

  String get languageCode => locale.languageCode;

  String get(String path) {
    String result;
    try {
      List<String> query = path.split('/');
      result = _findInMap(_translationMap, query);
    } catch (e) {
      result = 'Did not find \'$path\'';
    }
    if (result == null) result = 'Did not find \'$path\'';
    return result;
  }

  String _findInMap(Map<dynamic, dynamic> map, List<String> query) {
    if (query.length == 1) {
      return map[query.first];
    } else {
      return _findInMap(map[query.first], query.sublist(1, query.length));
    }
  }

  static Translation of(BuildContext context) =>
      Localizations.of<Translation>(context, Translation);
}
