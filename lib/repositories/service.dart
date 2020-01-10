import 'package:flutter/material.dart';

///Use-case independant interface that exchanges 
///[Input] for [Output] asynchronously
@immutable
abstract class Service<Input, Output> {

  ///Exchange one [Input] for a [Future<Output>]
  Future<Output> post(Input input);
}
