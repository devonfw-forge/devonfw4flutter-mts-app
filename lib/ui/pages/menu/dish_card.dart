import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_order_bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_order_event.dart';
import 'package:my_thai_star_flutter/models/dish.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/crop_image.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/labeled_checkbox.dart';

import '../../ui_helper.dart';

class DishCard extends StatelessWidget {
  static const double imageHeight = 200;
  static const double outerPadding = 8;
  final Dish dish;

  const DishCard({Key key, @required this.dish}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: outerPadding,
        right: outerPadding,
        top: outerPadding,
      ),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: UiHelper.elevation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CropImage(
              imageLocation: dish.imageLocation,
              imageHeight: imageHeight,
            ),
            Padding(
              padding: const EdgeInsets.all(UiHelper.card_margin),
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
                  SizedBox(height: UiHelper.standart_padding),
                  Text('${dish.description}',
                      style: Theme.of(context).textTheme.subtitle.copyWith(
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                          )),
                  SizedBox(height: UiHelper.standart_padding),
                  Wrap(
                    children: dish.extras
                        .map((e) => new LabeledCheckBox(label: e))
                        .toList(),
                  ),
                  SizedBox(height: UiHelper.standart_padding),
                  RaisedButton(
                    color: Theme.of(context).accentColor,
                    child: Text(
                      "ADD TO ORDER",
                      style: Theme.of(context).textTheme.button,
                    ),
                    onPressed: () => BlocProvider.of<CurrentOrderBloc>(context)
                        .dispatch(AddOrderEvent(dish)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
