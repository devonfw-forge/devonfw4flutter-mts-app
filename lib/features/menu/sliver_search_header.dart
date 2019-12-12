import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_thai_star_flutter/features/menu/blocs/current_search_bloc.dart';
import 'package:my_thai_star_flutter/features/menu/blocs/current_search_events.dart';
import 'package:my_thai_star_flutter/features/menu/blocs/dish_bloc.dart';
import 'package:my_thai_star_flutter/features/menu/models/search.dart';
import 'package:my_thai_star_flutter/features/menu/sarch_bar.dart';
import 'package:my_thai_star_flutter/ui_helper.dart';

class SliverSearchHeader extends StatelessWidget {
  static const double height = 160;

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
              SearchBar(),
              _Sort(),
              _Buttons(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Buttons extends StatelessWidget {
  const _Buttons({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FlatButton(
            child: Text(
              "CLEAR FILTERS",
              style: Theme.of(context).textTheme.button.copyWith(
                    color: Colors.grey,
                  ),
            ),
            onPressed: () {
              BlocProvider.of<CurrentSearchBloc>(context)
                  .dispatch(ClearSearchEvent());
            }),
        FlatButton(
          child: Text(
            "APPLY FILTERS",
            style: Theme.of(context).textTheme.button.copyWith(
                  color: Theme.of(context).accentColor,
                ),
          ),
          onPressed: () =>
              BlocProvider.of<DishBloc>(context).dispatch(DishEvents.request),
        ),
      ],
    );
  }
}

class _Sort extends StatelessWidget {
  static const double iconPadding = 12.0;
  static const double dropDownPadding = 5;

  const _Sort({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentSearchBloc, Search>(
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
              value: state.sortBy,
              items: Search.sortCriteria.map(
                (String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                },
              ).toList(),
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
}
