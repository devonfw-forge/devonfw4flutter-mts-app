import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class LocalizationState extends Equatable {
  final Locale locale;
  final Map<dynamic, dynamic> _translationMap;

  String get languageCode => locale.languageCode;

  LocalizationState(this.locale, this._translationMap);

  @override
  List<Object> get props => [locale];

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
}

@immutable
class InitialLocalizationState extends LocalizationState {
  InitialLocalizationState(Locale locale) : super(locale, null);

  @override
  String toString() => "Initial";
}

@immutable
class LoadedLocalizationState extends LocalizationState {
  LoadedLocalizationState(Locale locale, Map translationMap)
      : super(locale, translationMap);

  @override
  String toString() => "Idle/Language: " + languageCode;
}
