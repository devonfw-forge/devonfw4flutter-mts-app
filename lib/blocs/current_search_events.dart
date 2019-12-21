import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

///Gives the ability to change the current [Search]
@immutable
abstract class CurrentSearchEvent extends Equatable {}

///Sets the current [Search.query]
@immutable
class SetQueryEvent extends CurrentSearchEvent {
  final String query;

  SetQueryEvent(this.query);

  @override
  List<Object> get props => [query];

  @override
  String toString() => 'Query/' + query;
}

///Sets the current [Search.sortBy]
@immutable
class SetSortEvent extends CurrentSearchEvent {
  final String sortBy;

  SetSortEvent(this.sortBy);

  @override
  List<Object> get props => [sortBy];

  @override
  String toString() => 'SortBy/' + sortBy;
}

///Flips the current sort direction from 
///
///````dart
///Search.descending = !Search.descending
///````
@immutable
class FlipDirectionEvent extends CurrentSearchEvent {
  @override
  List<Object> get props => [toString()];

  @override
  String toString() => 'Flip';
}

@immutable
class ClearSearchEvent extends CurrentSearchEvent {
  @override
  List<Object> get props => [toString()];

  @override
  String toString() => 'Clear';
}
