import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_search_bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_search_events.dart';
import 'package:my_thai_star_flutter/models/search.dart';
import 'package:my_thai_star_flutter/blocs/localization_bloc.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController _queryController = TextEditingController();

  @override
  void initState() {
    String currentQuery =
        BlocProvider.of<CurrentSearchBloc>(context).currentState.query;

    //if(currentQuery != null) do this ?? else
    _queryController.text = currentQuery ?? "";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentSearchBloc, Search>(
      condition: (_, state) {
        //Only re-build if the query of the emitted State is null
        return state.query == null;
      },
      builder: (context, state) {
        if (state.query == null) _queryController.text = "";

        return TextField(
          controller: _queryController,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search),
            labelText: LocalizationBloc.of(context).get("menu/filter/search"),
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
