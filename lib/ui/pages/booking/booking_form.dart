import 'package:flutter/material.dart';

class BookingFrom extends StatelessWidget {
  static const imageLocation = "assets/images/slider-1.jpg";
  const BookingFrom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image(image: AssetImage(imageLocation)),
      ],
    );
  }
}
