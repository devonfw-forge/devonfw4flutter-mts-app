import 'package:bool_bloc/bool_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_order_bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_order_event.dart';
import 'package:my_thai_star_flutter/blocs/localization_bloc.dart';
import 'package:my_thai_star_flutter/models/dish.dart';
import 'package:my_thai_star_flutter/models/extra.dart';
import 'package:my_thai_star_flutter/ui/menu/labeled_checkbox.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/crop_image.dart';
import 'package:my_thai_star_flutter/ui/ui_helper.dart';

class DishCard extends StatefulWidget {
  static const double imageHeight = 200;
  static const double outerPadding = 8;
  final Dish dish;

  const DishCard({Key key, @required this.dish}) : super(key: key);

  @override
  _DishCardState createState() => _DishCardState(dish);
}

class _DishCardState extends State<DishCard> {
  Map<int, BoolBloc> checkboxBlocs = Map();
  Dish dish;

  _DishCardState(this.dish);

  @override
  void initState() {
    dish.extras.forEach(
      (Extra extra, bool picked) => checkboxBlocs[extra.id] = BoolBloc(),
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
              encodedImage: dish?.encodedImage,
              assetImage: dish?.assetImage,
              imageHeight: DishCard.imageHeight,
            ),
            Padding(
              padding: EdgeInsets.all(UiHelper.card_margin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${dish.price}',
                    style: Theme.of(context).textTheme.headline.copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                  SizedBox(height: UiHelper.card_margin),
                  Text('${dish.name}',
                      style: Theme.of(context).textTheme.title),
                  SizedBox(height: UiHelper.standard_padding),
                  Text('${dish.description}',
                      style: Theme.of(context).textTheme.subtitle.copyWith(
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                          )),
                  SizedBox(height: UiHelper.standard_padding),
                  Wrap(children: mapExtras()),
                  SizedBox(height: UiHelper.standard_padding),
                  RaisedButton(
                    color: Theme.of(context).accentColor,
                    child: Text(
                      LocalizationBloc.of(context).get("buttons/addToOrder"),
                      style: Theme.of(context).textTheme.button,
                    ),
                    onPressed: () => BlocProvider.of<CurrentOrderBloc>(context)
                        .dispatch(AddDishToOrderEvent(dish)),
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
    checkboxBlocs.forEach((id, bloc) => bloc.dispose());
    super.dispose();
  }

  List<Widget> mapExtras() {
    return dish.extras.keys
        .map(
          (Extra extra) => BlocBuilder<BoolBloc, bool>(
            bloc: checkboxBlocs[extra.id],
            builder: (context, state) => LabeledCheckBox(
              label: extra.name,
              state: state,
              onStateChange: (bool b) => onCheckboxStateChange(b, extra),
            ),
          ),
        )
        .toList();
  }

  void onCheckboxStateChange(bool b, Extra extra) {
    checkboxBlocs[extra.id].dispatch(BoolBlocEvent.swap);

    Map<Extra, bool> newExtras = Map.from(dish.extras);
    newExtras[extra] = b;

    dish = dish.copyWith(extras: newExtras);
  }
}
