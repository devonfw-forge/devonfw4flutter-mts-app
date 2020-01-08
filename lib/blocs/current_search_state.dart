import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/models/search.dart';

///Describes the current state of the current search
@immutable
abstract class CurrentSearchState extends Equatable {
  final Search search;

  CurrentSearchState(this.search);
}

@immutable
class InitialSearchState extends CurrentSearchState {
  InitialSearchState() : super(Search());

  @override
  List<Object> get props => [toString()];

  @override
  String toString() => 'Initial';
}

@immutable
class IdleSearchState extends CurrentSearchState {
  IdleSearchState(Search search) : super(search);

  @override
  List<Object> get props => [search];

  @override
  String toString() => 'Idle';
}

@immutable
class ClearedSearchState extends CurrentSearchState {
  ClearedSearchState() : super(Search());

  @override
  List<Object> get props => [toString()];

  @override
  String toString() => 'Cleared';
}
