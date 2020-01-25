import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_search_bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_search_events.dart';
import 'package:my_thai_star_flutter/blocs/dish_bloc.dart';
import 'package:my_thai_star_flutter/ui/localization.dart';

///Defines the [Row] of [FlatButton]s at the 
///bottom of the [SliverSearchHeader]
///
///Responsible for Dispatching [ClearSearchEvent]s 
///to the [CurrentSearchBloc]. Responsible for 
///Applying the current search by dispatching 
///[DishEvent.request]s to the [DishBloc].
class FilterButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FlatButton(
            child: Text(
              Translation.of(context).get('buttons/clearFilters'),
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
          child: Text(Translation.of(context).get('buttons/applyFilters'),
              style: Theme.of(context)
                  .textTheme
                  .button
                  .copyWith(color: Theme.of(context).accentColor)),
          onPressed: () =>
              BlocProvider.of<DishBloc>(context).dispatch(DishEvent.request),
        ),
      ],
    );
  }
}
