import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_order_bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_order_event.dart';
import 'package:my_thai_star_flutter/blocs/current_order_state.dart';
import 'package:my_thai_star_flutter/models/dish.dart';
import 'package:my_thai_star_flutter/localization/translation.dart';
import 'package:my_thai_star_flutter/models/order_position.dart';
import 'package:my_thai_star_flutter/ui/ui_helper.dart';

///Defines a single order position based on the provided [Dish] and
///the related amount
class OrderPositionDisplay extends StatelessWidget {
  final OrderPosition _position;

  const OrderPositionDisplay({Key key, @required position})
      : _position = position,
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
                .dispatch(RemoveOrderPositionEvent(_position)),
          ),
          _TextContent(dish: _position.dish),
          _Amount(_position),
          _Price(_position),
        ],
      ),
    );
  }
}

class _Price extends StatelessWidget {
  final OrderPosition _position;

  const _Price(this._position);

  @override
  Widget build(BuildContext context) {
    return Text(
      "${_position.formattedPrice} €",
      style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.grey),
    );
  }
}

class _Amount extends StatelessWidget {
  final OrderPosition _position;

  const _Amount(this._position);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: () => BlocProvider.of<CurrentOrderBloc>(context).dispatch(
            RemoveDishEvent(_position.dish),
          ),
        ),
        Text("${_position.amount}",
            style: Theme.of(context)
                .textTheme
                .subtitle
                .copyWith(color: Colors.grey)),
        IconButton(
          icon: Icon(Icons.add, color: Theme.of(context).accentColor),
          onPressed: () => BlocProvider.of<CurrentOrderBloc>(context)
              .dispatch(AddDishEvent(_position.dish)),
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
