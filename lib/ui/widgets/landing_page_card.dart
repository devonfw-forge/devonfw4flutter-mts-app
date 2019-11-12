import 'package:flutter/material.dart';

class LandingPageCard extends StatelessWidget {
  static const double _borderRadius = 6;
  static const double _textDistance = 10;
  static const double _contentMargin = 20;

  final String headline;
  final String text;
  final String imageLocation;
  final String buttonLable;
  final VoidCallback onPressed;

  const LandingPageCard({
    @required this.headline,
    @required this.text,
    @required this.imageLocation,
    @required this.buttonLable,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image(image: AssetImage(imageLocation)),
          Container(
            margin: EdgeInsets.all(_contentMargin),
            child: Column(
              children: <Widget>[
                Text(
                  headline,
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(height: _textDistance),
                Text(
                  text,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: _textDistance),
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
    );
  }
}
