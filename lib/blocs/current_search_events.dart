import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class CurrentSearchEvent extends Equatable {
  const CurrentSearchEvent();
}

@immutable
class SetQueryEvent extends CurrentSearchEvent {
  final String query;

  SetQueryEvent(this.query);

  @override
  List<Object> get props => [query];
}

@immutable
class SetSortEvent extends CurrentSearchEvent {
  final String sortBy;

  SetSortEvent(this.sortBy);

  @override
  List<Object> get props => [sortBy];
}

@immutable
class FlipDirectionEvent extends CurrentSearchEvent {
  @override
  List<Object> get props => ["flip"];
}

@immutable
class ClearSearchEvent extends CurrentSearchEvent {
  @override
  List<Object> get props => ["clear"];
}
