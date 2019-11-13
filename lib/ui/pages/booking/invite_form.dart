import 'package:flutter/material.dart';

class InviteFrom extends StatelessWidget {
  static const imageLocation = "assets/images/slider-2.jpg";
  static const double imageHeight = 400;
  
  const InviteFrom({Key key}) : super(key: key);

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
