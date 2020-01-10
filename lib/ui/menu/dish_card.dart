import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_thai_star_flutter/blocs/dish_card_bloc.dart';
import 'package:my_thai_star_flutter/blocs/dish_card_event.dart';
import 'package:my_thai_star_flutter/blocs/current_order_bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_order_event.dart';
import 'package:my_thai_star_flutter/localization.dart';
import 'package:my_thai_star_flutter/models/dish.dart';
import 'package:my_thai_star_flutter/models/extra.dart';
import 'package:my_thai_star_flutter/ui/menu/labeled_checkbox.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/crop_image.dart';
import 'package:my_thai_star_flutter/ui/ui_helper.dart';

///Displays one [Dish] & gives the option to add it
///to the current order.
///
///The original state of [Dish] is set through the [_initialDish]
///member. From there on out the state of the [Dish] can be modified
///by selecting and deselecting [Extra]s. These state changes are
///tracked with a [DishCardBloc].
class DishCard extends StatefulWidget {
  final Dish _initialDish;

  const DishCard({Key key, @required initialDish})
      : _initialDish = initialDish,
        super(key: key);

  @override
  _DishCardState createState() => _DishCardState(_initialDish);
}

class _DishCardState extends State<DishCard> {
  static const double _imageHeight = 200;

  final Dish _initialDish;
  DishCardBloc _dishCardBloc;

  _DishCardState(initialDish) : _initialDish = initialDish;

  @override
  void initState() {
    //Inject initial dish state
    _dishCardBloc = DishCardBloc(_initialDish);

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
              encodedImage: _initialDish?.encodedImage,
              assetImage: _initialDish?.assetImage,
              imageHeight: _imageHeight,
            ),
            Padding(
              padding: EdgeInsets.all(UiHelper.card_margin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${_initialDish.price}',
                    style: Theme.of(context).textTheme.headline.copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                  SizedBox(height: UiHelper.card_margin),
                  Text('${_initialDish.name}',
                      style: Theme.of(context).textTheme.title),
                  SizedBox(height: UiHelper.standard_padding),
                  Text('${_initialDish.description}',
                      style: Theme.of(context).textTheme.subtitle.copyWith(
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                          )),
                  SizedBox(height: UiHelper.standard_padding),
                  BlocBuilder<DishCardBloc, Dish>(
                    bloc: _dishCardBloc,
                    builder: (context, dishState) => Column(
                      //Rebuild checkboxes and pass new dishState to the
                      //[_AddButton] when new state is emitted.
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _Extras(dishCardBloc: _dishCardBloc),
                        SizedBox(height: UiHelper.standard_padding),
                        _AddButton(dish: dishState),
                      ],
                    ),
                  ),
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
    _dishCardBloc.dispose();
    super.dispose();
  }
}

///Adds the given [Dish] to the [CurrentOrderBloc] when pressed.
class _AddButton extends StatelessWidget {
  const _AddButton({
    @required Dish dish,
    Key key,
  })  : _dish = dish,
        super(key: key);

  final Dish _dish;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Theme.of(context).accentColor,
      child: Text(
        Translation.of(context).get('buttons/addToOrder'),
        style: Theme.of(context).textTheme.button,
      ),
      //Dispatch current version of the Dish
      onPressed: () => BlocProvider.of<CurrentOrderBloc>(context)
          .dispatch(AddDishEvent(_dish)),
    );
  }
}

///Displays a [LabeledCheckBox] for each [Extra] of the current 
///state of the [DishCardBloc]
class _Extras extends StatelessWidget {
  const _Extras({
    Key key,
    @required DishCardBloc dishCardBloc,
  })  : _dishCardBloc = dishCardBloc,
        super(key: key);

  final DishCardBloc _dishCardBloc;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _mapExtras(),
    );
  }

  ///Maps each [Extra] to a [LabeledCheckBox]
  ///
  ///Defines that a [SetExtraEvent] is dispatched to the [DishCardBloc]
  ///when the [LabeledCheckBox] is pressed.
  List<Widget> _mapExtras() {
    Dish dish = _dishCardBloc.currentState;

    return dish.extras.keys
        .map(
          (Extra extra) => LabeledCheckBox(
            label: extra.name,
            state: dish.extras[extra],
            onStateChange: (bool picked) => _dishCardBloc.dispatch(
              SetExtraEvent(
                extra: extra,
                picked: picked,
              ),
            ),
          ),
        )
        .toList();
  }
}
