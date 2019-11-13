import 'package:flutter/material.dart';

class BookingFrom extends StatelessWidget {
  static const imageLocation = "assets/images/slider-1.jpg";
  static const double imageHeight = 400;

  const BookingFrom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: imageHeight,
          decoration: BoxDecoration(
              image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(imageLocation),
          )),
        ),
      ],
    );
  }
}
