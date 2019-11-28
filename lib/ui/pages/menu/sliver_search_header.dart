import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_thai_star_flutter/blocs/dish_bloc.dart';
import 'package:my_thai_star_flutter/blocs/dish_state.dart';
import 'package:my_thai_star_flutter/models/search.dart';

import '../../ui_helper.dart';

class SliverSearchHeader extends StatelessWidget {
  static const double height = 120;

  const SliverSearchHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: UiHelper.elevation,
      floating: true,
      backgroundColor: Colors.white,
      leading: Container(),
      expandedHeight: height,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              _SearchBar(),
              _Sort(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: InputBorder.none,
        prefixIcon: Icon(Icons.search),
        labelText: "Search our Dishes",
      ),
    );
  }
}

class _Sort extends StatelessWidget {
  const _Sort({Key key}) : super(key: key);

  static const double iconPadding = 12.0;
  static const double dropDownPadding = 5;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DishBloc, DishState>(
      builder: (context, state) => Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(iconPadding),
            child: Icon(
              Icons.sort,
              color: Colors.grey,
            ),
          ),
          Text(
            "Sort by",
            style: Theme.of(context).textTheme.subhead,
          ),
          SizedBox(
            width: dropDownPadding,
          ),
          Expanded(
            child: DropdownButton<String>(
              isExpanded: true,
              value: state.lastSearch.sortBy,
              items: Search.sortCriteria.map(
                (String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                },
              ).toList(),
              onChanged: (String sortBy) => BlocProvider.of<DishBloc>(context)
                  .dispatch(state.lastSearch.copyWith(sortBy: sortBy)),
            ),
          ),
          IconButton(
            icon: Icon(
              state.lastSearch.descending
                  ? Icons.vertical_align_bottom
                  : Icons.vertical_align_top,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () => BlocProvider.of<DishBloc>(context).dispatch(state
                .lastSearch
                .copyWith(descending: !state.lastSearch.descending)),
          ),
        ],
      ),
    );
  }
}
