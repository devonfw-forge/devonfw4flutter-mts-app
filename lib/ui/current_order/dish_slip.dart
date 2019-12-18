import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_order_bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_order_event.dart';
import 'package:my_thai_star_flutter/blocs/current_order_state.dart';
import 'package:my_thai_star_flutter/models/dish.dart';
import 'package:my_thai_star_flutter/blocs/localization_bloc.dart';
import 'package:my_thai_star_flutter/ui/ui_helper.dart';

class DishSlip extends StatelessWidget {
  static const double textDistance = 3;
  final Dish dish;
  final int amount;

  const DishSlip({
    Key key,
    @required this.dish,
    @required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(UiHelper.standard_padding),
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () => BlocProvider.of<CurrentOrderBloc>(context)
                .dispatch(DeleteOrderPositionEvent(dish)),
          ),
          _TextContent(
            dish: dish,
            textDistance: textDistance,
          ),
          _Amount(
            amount: amount,
            order: dish,
          ),
          _Price(dish: dish),
        ],
      ),
    );
  }
}

class _Price extends StatelessWidget {
  const _Price({Key key, @required this.dish}) : super(key: key);

  final Dish dish;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentOrderBloc, CurrentOrderState>(
      builder: (context, state) => Text(
        "${state.formattedPositionPrice(dish)} €",
        style:
            Theme.of(context).textTheme.subtitle.copyWith(color: Colors.grey),
      ),
    );
  }
}

class _Amount extends StatelessWidget {
  final int amount;
  final Dish order;
  const _Amount({
    Key key,
    @required this.amount,
    @required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: () => BlocProvider.of<CurrentOrderBloc>(context).dispatch(
            RemoveDishFromOrderEvent(order),
          ),
        ),
        Text("$amount",
            style: Theme.of(context)
                .textTheme
                .subtitle
                .copyWith(color: Colors.grey)),
        IconButton(
          icon: Icon(Icons.add, color: Theme.of(context).accentColor),
          onPressed: () => BlocProvider.of<CurrentOrderBloc>(context)
              .dispatch(AddDishToOrderEvent(order)),
        ),
      ],
    );
  }
}

class _TextContent extends StatelessWidget {
  const _TextContent({
    Key key,
    @required this.dish,
    @required this.textDistance,
  }) : super(key: key);

  final Dish dish;
  final double textDistance;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            dish.name,
            style: Theme.of(context)
                .textTheme
                .subtitle
                .copyWith(color: Colors.black),
          ),
          _extras(context),
          //_commentButton(context),
        ],
      ),
    );
  }

  Widget _extras(BuildContext context) {
    if (dish.hasExtras()) {
      return Column(
        children: <Widget>[
          SizedBox(height: textDistance),
          Text(
            "${dish.selectedExtras()}",
            style: TextStyle(color: Theme.of(context).accentColor),
          ),
        ],
      );
    } else {
      return SizedBox();
    }
  }

  Widget _commentButton(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: textDistance),
        Text(
          LocalizationBloc.of(context).get("buttons/addComment"),
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
      ],
    );
  }
}
