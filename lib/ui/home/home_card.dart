import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/ui/ui_helper.dart';

///[Card] in the [home]-page [CardDisplay]
///
///holds and image, title and button that navigates to a
///different part of the app
class HomeCard extends StatelessWidget {
  final String _headline;
  final String _text;
  final String _imageLocation;
  final String _buttonLabel;
  final VoidCallback _onPressed;

  const HomeCard({
    @required headline,
    @required text,
    @required imageLocation,
    @required buttonLabel,
    onPressed,
  }): _headline = headline,
        _text = text,
        _imageLocation = imageLocation,
        _buttonLabel = buttonLabel,
        _onPressed = onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(UiHelper.standard_padding),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: UiHelper.elevation,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image(image: AssetImage(_imageLocation)),
            Container(
              margin: EdgeInsets.all(UiHelper.card_margin),
              child: Column(
                children: <Widget>[
                  Text(
                    _headline,
                    style: Theme
                        .of(context)
                        .textTheme
                        .title,
                  ),
                  SizedBox(height: UiHelper.standard_padding),
                  Text(
                    _text,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: UiHelper.standard_padding),
                  RaisedButton(
                    child: Text(
                      _buttonLabel,
                      style: Theme
                          .of(context)
                          .textTheme
                          .button,
                    ),
                    color: Theme
                        .of(context)
                        .accentColor,
                    onPressed: _onPressed,
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
