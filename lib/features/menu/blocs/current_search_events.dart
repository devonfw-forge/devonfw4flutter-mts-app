import 'package:equatable/equatable.dart';
import 'package:my_thai_star_flutter/features/menu/models/dish.dart';

abstract class CurrentSearchEvent extends Equatable {
  const CurrentSearchEvent();
}

class SetQueryEvent extends CurrentSearchEvent {
  final String query;

  SetQueryEvent(this.query);

  @override
  List<Object> get props => [query];
}
class SetSortEvent extends CurrentSearchEvent {
  final String sortBy;

  SetSortEvent(this.sortBy);

  @override
  List<Object> get props => [sortBy];
}
class FlipDirectionEvent extends CurrentSearchEvent {

  @override
  List<Object> get props => ["flip"];
}
class ClearSearchEvent extends CurrentSearchEvent {

  @override
  List<Object> get props => ["clear"];
}

