import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_search_events.dart';
import 'package:my_thai_star_flutter/models/search.dart';

class CurrentSearchBloc extends Bloc<CurrentSearchEvent, Search> {
  @override
  Search get initialState => Search();

  @override
  Stream<Search> mapEventToState(CurrentSearchEvent event) async* {
    Search newSearch;

    if (event is SetQueryEvent) {
      newSearch = currentState.copyWith(query: (state as SetQueryEvent).query);
    }
    if (event is SetSortEvent) {
      newSearch = currentState.copyWith(sortBy: (state as SetSortEvent).sortBy);
    }
    if (event is FlipDirectionEvent) {
      newSearch = currentState.copyWith(descending: !currentState.descending);
    }

    yield newSearch;
  }
}
