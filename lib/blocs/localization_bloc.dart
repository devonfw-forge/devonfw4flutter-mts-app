import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class LocalizationBloc extends Bloc<Locale, Locale> {
  @override
  Locale get initialState => Locale("de");

  @override
  Stream<Locale> mapEventToState(Locale event) async* {
    yield event;
  }
}
