import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

///Generates and then provides a set of [Translation] objects to the WidgetTree
///
///Flutters in-build way of handling Localization is through [LocalizationsDelegate]s.
///We can create a custom one for out localized texts.
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

  ///Generates on [Translation] for a given [Locale]
  @override
  Future<Translation> load(Locale locale) async {
    Map<dynamic, dynamic> translationMap = await _loadFromAssets(locale);
    return Translation(locale, translationMap);
  }

  @override
  bool shouldReload(LocalizationsDelegate<Translation> old) => false;

  ///Loads a translation JSON file of a given [Locale] form the assets
  ///an parsed it to a [Map<dynamic, dynamic>].
  static Future<Map<dynamic, dynamic>> _loadFromAssets(Locale locale) async {
    String jsonContent = await rootBundle
        .loadString('assets/languages/${locale.languageCode}.json');

    return json.decode(jsonContent);
  }
}

///Holds a translation of all MyThaiStar texts for one given [Locale]
///
///We can access the current [Translation] like this:
///````dart
///Localizations.of<Translation>(context, Translation);
/////or this
///Translation.of(context);
///````
///The current [Translation] is defined by, and can be changed
///with through the [LocalizationBloc].
///Whenever the current [Translation] changes, all Widgets accessing it 
///will automatically be rebuilt by the Framework.
///
///I did not re-implement this behavior with the bloc-pattern, because
///handleing widget updates manually lead to a lot of boilerplate.
@immutable
class Translation {
  ///JSON holding the translation
  final Map<dynamic, dynamic> _translationMap;
  final Locale locale;

  const Translation(this.locale, this._translationMap);

  String get languageCode => locale.languageCode;

  ///Returns translation of a given path
  ///
  ///paths are a shorter way of accessing the json data
  ///stored in the [_translationMap].
  ///````dart
  /////instead of this:
  ///Translation.of(context).map['menu']['header']['title'];
  /////we can do this:
  ///Translation.of(context).get('menu/header/title');
  ///````
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

  ///Gives one translation that matches the given [query]
  ///
  ///Recursively searches through the map
  String _findInMap(Map<dynamic, dynamic> map, List<String> query) {
    if (query.length == 1) {
      return map[query.first];
    } else {
      return _findInMap(map[query.first], query.sublist(1, query.length));
    }
  }

  ///Enables a shorter way of accessing the current [Translation]
  static Translation of(BuildContext context) =>
      Localizations.of<Translation>(context, Translation);
}
