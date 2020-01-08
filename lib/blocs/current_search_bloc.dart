import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_search_events.dart';
import 'package:my_thai_star_flutter/blocs/current_search_state.dart';
import 'package:my_thai_star_flutter/models/search.dart';

///Handles the state of the current [Search]
///
///Consumes [CurrentSearchEvent]s and mutates the current [Search]
///based on those events. The [CurrentSearchBloc] then emits the
///mutated [CurrentSearchState] containing the mutated [Search].
class CurrentSearchBloc extends Bloc<CurrentSearchEvent, CurrentSearchState> {
  @override
  CurrentSearchState get initialState => InitialSearchState();

  @override
  Stream<CurrentSearchState> mapEventToState(CurrentSearchEvent event) async* {
    Search newSearch;

    if (event is ClearSearchEvent) {
      yield ClearedSearchState();
      return;
    }

    if (event is SetQueryEvent) {
      newSearch = currentState.search.copyWith(query: event.query);
    } else if (event is SetSortEvent) {
      newSearch = currentState.search.copyWith(sortBy: event.sortBy);
    } else if (event is FlipDirectionEvent) {
      newSearch = currentState.search
          .copyWith(descending: !currentState.search.descending);
    }

    yield IdleSearchState(newSearch);
  }
}
