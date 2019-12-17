import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class MtsLocalization {
  final Map<dynamic, dynamic> map;

  MtsLocalization(this.map);

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
}
