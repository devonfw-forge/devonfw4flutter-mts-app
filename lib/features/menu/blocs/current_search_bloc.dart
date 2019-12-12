import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:my_thai_star_flutter/features/menu/blocs/current_search_events.dart';
import 'package:my_thai_star_flutter/features/menu/models/search.dart';

class CurrentSearchBloc extends Bloc<CurrentSearchEvent, Search> {
  @override
  Search get initialState => Search();

  @override
  Stream<Search> mapEventToState(CurrentSearchEvent event) async* {
    Search newSearch;

    if (event is SetQueryEvent) {
      newSearch = currentState.copyWith(query: event.query);
    }
    if (event is SetSortEvent) {
      newSearch = currentState.copyWith(sortBy: event.sortBy);
    }
    if (event is FlipDirectionEvent) {
      newSearch = currentState.copyWith(descending: !currentState.descending);
    }
    if (event is ClearSearchEvent) {
      newSearch = Search();
    }

    yield newSearch;
  }
}
