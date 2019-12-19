import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_search_bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_search_events.dart';
import 'package:my_thai_star_flutter/localization.dart';
import 'package:my_thai_star_flutter/models/search.dart';

///Defines a [Widget] which enables the user to select a sort
///criteria and a sort direction.
///
///The [SortDropdown] dispatches [SetSortEvent]s to the 
///[CurrentSearchBloc] to modify the current sort criteria.
///The [SortDropdown] dispatches [FlipDirectionEvent]s to the 
///[CurrentSearchBloc] to modify the current sort direction.
class SortDropdown extends StatelessWidget {
  static const double _iconPadding = 12.0;
  static const double _dropDownPadding = 5;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentSearchBloc, Search>(
      builder: (context, state) => Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(_iconPadding),
            child: Icon(Icons.sort, color: Colors.grey),
          ),
          Text(
            Translation.of(context).get("menu/filter/sort"),
            style: Theme.of(context).textTheme.subhead,
          ),
          SizedBox(width: _dropDownPadding),
          Expanded(
            child: DropdownButton<String>(
              isExpanded: true,
              value: state.sortBy,
              items: _mapDropDownItems(context),
              onChanged: (String sortBy) =>
                  BlocProvider.of<CurrentSearchBloc>(context)
                      .dispatch(SetSortEvent(sortBy)),
            ),
          ),
          IconButton(
            icon: Icon(
              state.descending
                  ? Icons.vertical_align_bottom
                  : Icons.vertical_align_top,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () => BlocProvider.of<CurrentSearchBloc>(context)
                .dispatch(FlipDirectionEvent()),
          ),
        ],
      ),
    );
  }

  ///Maps each [Search.sortCriteria] to a [DropdownMenuItem]
  List<DropdownMenuItem<String>> _mapDropDownItems(BuildContext context) {
    return Search.sortCriteria
        .map((String value) => DropdownMenuItem<String>(
              value: value,
              child: Text(
                Translation.of(context).get("menu/filter/$value"),
              ),
            ))
        .toList();
  }
}