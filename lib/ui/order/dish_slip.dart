import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_order_bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_order_event.dart';
import 'package:my_thai_star_flutter/blocs/current_order_state.dart';
import 'package:my_thai_star_flutter/models/dish.dart';
import 'package:my_thai_star_flutter/localization/translation.dart';
import 'package:my_thai_star_flutter/ui/ui_helper.dart';

class DishSlip extends StatelessWidget {
  final Dish _dish;
  final int _amount;

  const DishSlip({Key key, @required dish, @required amount})
      : _dish = dish,
        _amount = amount,
        super(key: key);

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
                .dispatch(DeleteOrderPositionEvent(_dish)),
          ),
          _TextContent(dish: _dish),
          _Amount(amount: _amount, dish: _dish),
          _Price(dish: _dish),
        ],
      ),
    );
  }
}

class _Price extends StatelessWidget {
  final Dish _dish;

  const _Price({Key key, @required dish})
      : _dish = dish,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentOrderBloc, CurrentOrderState>(
      builder: (context, state) => Text(
        "${state.formattedPositionPrice(_dish)} €",
        style:
            Theme.of(context).textTheme.subtitle.copyWith(color: Colors.grey),
      ),
    );
  }
}

class _Amount extends StatelessWidget {
  final int _amount;
  final Dish _dish;

  const _Amount({Key key, @required amount, @required dish})
      : _amount = amount,
        _dish = dish,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: () => BlocProvider.of<CurrentOrderBloc>(context).dispatch(
            RemoveDishFromOrderEvent(_dish),
          ),
        ),
        Text("$_amount",
            style: Theme.of(context)
                .textTheme
                .subtitle
                .copyWith(color: Colors.grey)),
        IconButton(
          icon: Icon(Icons.add, color: Theme.of(context).accentColor),
          onPressed: () => BlocProvider.of<CurrentOrderBloc>(context)
              .dispatch(AddDishToOrderEvent(_dish)),
        ),
      ],
    );
  }
}

class _TextContent extends StatelessWidget {
  static const double _textDistance = 3;
  static const int _flex = 2;

  final Dish _dish;

  const _TextContent({Key key, @required dish})
      : _dish = dish,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: _flex,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            _dish.name,
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
    if (_dish.hasExtras()) {
      return Column(
        children: <Widget>[
          SizedBox(height: _textDistance),
          Text(
            "${_dish.selectedExtras()}",
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
        SizedBox(height: _textDistance),
        Text(
          Translation.of(context).get("buttons/addComment"),
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
      ],
    );
  }
}
