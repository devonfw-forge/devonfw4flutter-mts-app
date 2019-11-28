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
          child: BlocBuilder<DishBloc, DishState>(
            builder: (context, state) => Column(
              children: <Widget>[
                _SearchBar(state: state),
                _Sort(state: state),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  final DishState state;
  const _SearchBar({Key key, this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: InputBorder.none,
        prefixIcon: Icon(Icons.search),
        labelText: "Search our Dishes",
      ),
      onChanged: (String query) => BlocProvider.of<DishBloc>(context)
          .dispatch(state.lastSearch.copyWith(query: query)),
    );
  }
}

class _Sort extends StatelessWidget {
  static const double iconPadding = 12.0;
  static const double dropDownPadding = 5;

  final DishState state;

  const _Sort({Key key, this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
