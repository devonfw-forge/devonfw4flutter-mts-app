import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class CurrentSearchEvent extends Equatable {}

@immutable
class SetQueryEvent extends CurrentSearchEvent {
  final String query;

  SetQueryEvent(this.query);

  @override
  List<Object> get props => [query];

  @override
  String toString() => "Query/" + query;
}

@immutable
class SetSortEvent extends CurrentSearchEvent {
  final String sortBy;

  SetSortEvent(this.sortBy);

  @override
  List<Object> get props => [sortBy];

  @override
  String toString() => "SortBy/" + sortBy;
}

@immutable
class FlipDirectionEvent extends CurrentSearchEvent {
  @override
  List<Object> get props => [toString()];

  @override
  String toString() => "Flip";
}

@immutable
class ClearSearchEvent extends CurrentSearchEvent {
  @override
  List<Object> get props => [toString()];

  @override
  String toString() => "Clear";
}
