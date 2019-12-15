import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Extra extends Equatable {
  final int id;
  final String name;

  Extra({@required this.name, @required this.id});

  @override
  List<Object> get props => [name, id];
}
