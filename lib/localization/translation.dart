import 'package:flutter/material.dart';

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
      result = "Did not find \"$path\"";
    }
    if (result == null) result = "Did not find \"$path\"";
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