import 'package:flutter/material.dart';

///Gives the ability to change the current [Search]
@immutable
abstract class CurrentSearchEvent {}

///Sets the current [Search.query]
@immutable
class SetQueryEvent extends CurrentSearchEvent {
  final String query;

  SetQueryEvent(this.query);

  @override
  String toString() => 'Query/' + query;
}

///Sets the current [Search.sortBy]
@immutable
class SetSortEvent extends CurrentSearchEvent {
  final String sortBy;

  SetSortEvent(this.sortBy);

  @override
  String toString() => 'SortBy/' + sortBy;
}

///Flips the current sort direction
///
///````dart
///Search.descending = !Search.descending
///````
@immutable
class FlipDirectionEvent extends CurrentSearchEvent {
  @override
  String toString() => 'Flip';
}

@immutable
class ClearSearchEvent extends CurrentSearchEvent {
  @override
  String toString() => 'Clear';
}
