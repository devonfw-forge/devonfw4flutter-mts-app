
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

///Responsible for handling the current [Locale]
///
///Consumes [Locale]s as events and emits them as state.
///Think of the [LocalizationBloc] as a cash that hold the 
///current [Locale] and notifies its listeners once the [Locale]
///changes.
class LocalizationBloc extends Bloc<Locale, Locale> {
  static const Locale defaultLocale = Locale('en');

  @override
  Locale get initialState => defaultLocale;

  @override
  Stream<Locale> mapEventToState(Locale event) async* {
    yield event;
  }
}
