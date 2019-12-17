import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class MtsLocalization {
  final Map<dynamic, dynamic> _map;

  MtsLocalization(Map<dynamic, dynamic> map) : _map = map;

  static Future<MtsLocalization> load(Locale locale) async {
    Map<dynamic, dynamic> data = await _loadFromAssest(locale);
    return MtsLocalization(data);
  }

  static Future<Map<dynamic, dynamic>> _loadFromAssest(Locale locale) async {
    String jsonContent = await rootBundle
        .loadString("assets/languages/${locale.languageCode}.json");
    return json.decode(jsonContent);
  }

  static MtsLocalization of(BuildContext context) =>
      Localizations.of<MtsLocalization>(context, MtsLocalization);

  String get(String path) {
    String result;
    try {
      List<String> query = path.split('/');
      result = _findInMap(_map, query);
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
}
