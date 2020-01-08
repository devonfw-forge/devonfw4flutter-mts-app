import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_search_bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_search_events.dart';
import 'package:my_thai_star_flutter/blocs/current_search_state.dart';
import 'package:my_thai_star_flutter/models/search.dart';
import 'package:my_thai_star_flutter/localization.dart';

///Defines a [TextField] that acts as the search bar for the [MenuPage] 
///
///The [SearchBar] dispatched [SetQueryEvent]s to the [CurrentSearchBloc]
///whenever it's text it changed. 
class SearchBar extends StatefulWidget {

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController _queryController = TextEditingController();

  @override
  void initState() {
    String currentQuery =
        BlocProvider.of<CurrentSearchBloc>(context).currentState.search.query;

    //load the current query into the TextField if it is not null
    _queryController.text = currentQuery ?? '';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentSearchBloc, CurrentSearchState>(
      builder: (context, state) {
        if (state is ClearedSearchState) _queryController.text = '';

        return TextField(
          controller: _queryController,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search),
            labelText: Translation.of(context).get('menu/filter/search'),
          ),
          onChanged: (String query) =>
              BlocProvider.of<CurrentSearchBloc>(context)
                  .dispatch(SetQueryEvent(query)),
        );
      },
    );
  }

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }
}
