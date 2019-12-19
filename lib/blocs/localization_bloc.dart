
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

class LocalizationBloc extends Bloc<Locale, Locale> {
  static const Locale defaultLocale = Locale("en");

  @override
  Locale get initialState => defaultLocale;

  @override
  Stream<Locale> mapEventToState(Locale event) async* {
    yield event;
  }
}
