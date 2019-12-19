import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_search_bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_search_events.dart';
import 'package:my_thai_star_flutter/blocs/dish_bloc.dart';
import 'package:my_thai_star_flutter/localization/translation.dart';

class FilterButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FlatButton(
            child: Text(
              Translation.of(context).get("buttons/clearFilters"),
              style: Theme.of(context)
                  .textTheme
                  .button
                  .copyWith(color: Colors.grey),
            ),
            onPressed: () {
              BlocProvider.of<CurrentSearchBloc>(context)
                  .dispatch(ClearSearchEvent());
            }),
        FlatButton(
          child: Text(Translation.of(context).get("buttons/applyFilters"),
              style: Theme.of(context)
                  .textTheme
                  .button
                  .copyWith(color: Theme.of(context).accentColor)),
          onPressed: () =>
              BlocProvider.of<DishBloc>(context).dispatch(DishEvents.request),
        ),
      ],
    );
  }
}
