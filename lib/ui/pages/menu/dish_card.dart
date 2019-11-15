import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/models/dish.dart';
import 'package:my_thai_star_flutter/ui/pages/menu/extra_checkbox.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/crop_image.dart';

import '../../ui_helper.dart';

class DishCard extends StatelessWidget {
  final Dish dish;

  const DishCard({Key key, @required this.dish}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: UiHelper.elevation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CropImage(
              imageLocation: dish.imageLocation,
              imageHeight: 200,
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
                        .map((e) => new ExtraCheckBox(extraName: e))
                        .toList(),
                  ),
                  SizedBox(height: UiHelper.standart_padding),
                  RaisedButton(
                    color: Theme.of(context).accentColor,
                    child: Text(
                      "ADD TO ORDER",
                      style: Theme.of(context).textTheme.button,
                    ),
                    onPressed: () {},
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
