import 'package:bool_bloc/bool_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_order_bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_order_event.dart';
import 'package:my_thai_star_flutter/localization/translation.dart';
import 'package:my_thai_star_flutter/models/dish.dart';
import 'package:my_thai_star_flutter/models/extra.dart';
import 'package:my_thai_star_flutter/ui/menu/labeled_checkbox.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/crop_image.dart';
import 'package:my_thai_star_flutter/ui/ui_helper.dart';

class DishCard extends StatefulWidget {
  final Dish _dish;

  const DishCard({Key key, @required dish}) :
        _dish = dish,
        super(key: key);

  @override
  _DishCardState createState() => _DishCardState(_dish);
}

class _DishCardState extends State<DishCard> {
  static const double _imageHeight = 200;

  Map<int, BoolBloc> _checkboxBlocs = Map();
  Dish _dish;

  _DishCardState(dish) : _dish = dish;

  @override
  void initState() {
    _dish.extras.forEach(
      (Extra extra, bool picked) => _checkboxBlocs[extra.id] = BoolBloc(),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: UiHelper.standard_padding,
        right: UiHelper.standard_padding,
        left: UiHelper.standard_padding,
      ),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CropImage(
              encodedImage: _dish?.encodedImage,
              assetImage: _dish?.assetImage,
              imageHeight: _imageHeight,
            ),
            Padding(
              padding: EdgeInsets.all(UiHelper.card_margin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${_dish.price}',
                    style: Theme.of(context).textTheme.headline.copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                  SizedBox(height: UiHelper.card_margin),
                  Text('${_dish.name}',
                      style: Theme.of(context).textTheme.title),
                  SizedBox(height: UiHelper.standard_padding),
                  Text('${_dish.description}',
                      style: Theme.of(context).textTheme.subtitle.copyWith(
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                          )),
                  SizedBox(height: UiHelper.standard_padding),
                  Wrap(children: _mapExtras()),
                  SizedBox(height: UiHelper.standard_padding),
                  RaisedButton(
                    color: Theme.of(context).accentColor,
                    child: Text(
                      Translation.of(context).get("buttons/addToOrder"),
                      style: Theme.of(context).textTheme.button,
                    ),
                    onPressed: () => BlocProvider.of<CurrentOrderBloc>(context)
                        .dispatch(AddDishEvent(_dish)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _checkboxBlocs.forEach((id, bloc) => bloc.dispose());
    super.dispose();
  }

  List<Widget> _mapExtras() {
    return _dish.extras.keys
        .map(
          (Extra extra) => BlocBuilder<BoolBloc, bool>(
            bloc: _checkboxBlocs[extra.id],
            builder: (context, state) => LabeledCheckBox(
              label: extra.name,
              state: state,
              onStateChange: (bool b) => _onCheckboxStateChange(b, extra),
            ),
          ),
        )
        .toList();
  }

  void _onCheckboxStateChange(bool b, Extra extra) {
    _checkboxBlocs[extra.id].dispatch(BoolBlocEvent.swap);

    Map<Extra, bool> newExtras = Map.from(_dish.extras);
    newExtras[extra] = b;

    _dish = _dish.copyWith(extras: newExtras);
  }
}
