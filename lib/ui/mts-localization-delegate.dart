import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/ui/mts-localization.dart';

class MtsLocalizationDelegate extends LocalizationsDelegate<MtsLocalization> {
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
  Future<MtsLocalization> load(Locale locale) async =>
      MtsLocalization.load(locale);

  @override
  bool shouldReload(LocalizationsDelegate<MtsLocalization> old) => false;
}
