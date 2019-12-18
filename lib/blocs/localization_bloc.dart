import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_thai_star_flutter/blocs/localization_state.dart';
import 'package:flutter/services.dart' show rootBundle;

class LocalizationBloc extends Bloc<Locale, LocalizationState> {
  static const Locale defaultLocale = Locale("en");
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
  LocalizationState get initialState => InitialLocalizationState(defaultLocale);

  @override
  Stream<LocalizationState> mapEventToState(Locale event) async* {
    if (!supportedLanguages.contains(event.languageCode)) event = defaultLocale;

    Map<dynamic, dynamic> newTranslation = await _loadFromAssets(event);
    yield LoadedLocalizationState(event, newTranslation);
  }

  static Future<Map<dynamic, dynamic>> _loadFromAssets(Locale locale) async {
    String jsonContent = await rootBundle
        .loadString("assets/languages/${locale.languageCode}.json");

    return json.decode(jsonContent);
  }

  static LocalizationState of(BuildContext context) =>
      BlocProvider.of<LocalizationBloc>(context).currentState;
}
