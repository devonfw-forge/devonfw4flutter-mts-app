import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/ui_helper.dart';

///[Card] in the [home]-page [CardDisplay]
///
///holds and image, title and button that navigates to a
///different part of the app
class HomeCard extends StatelessWidget {
  final String headline;
  final String text;
  final String imageLocation;
  final String buttonLable;
  final VoidCallback onPressed;

  const HomeCard({
    @required this.headline,
    @required this.text,
    @required this.imageLocation,
    @required this.buttonLable,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(UiHelper.standart_padding),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: UiHelper.elevation,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image(image: AssetImage(imageLocation)),
            Container(
              margin: EdgeInsets.all(UiHelper.card_margin),
              child: Column(
                children: <Widget>[
                  Text(
                    headline,
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(height: UiHelper.standart_padding),
                  Text(
                    text,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: UiHelper.standart_padding),
                  RaisedButton(
                    child: Text(
                      buttonLable,
                      style: Theme.of(context).textTheme.button,
                    ),
                    color: Theme.of(context).accentColor,
                    onPressed: onPressed,
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
