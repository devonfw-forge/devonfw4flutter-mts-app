import 'package:flutter/material.dart';

class InviteFrom extends StatelessWidget {
  static const imageLocation = "assets/images/slider-2.jpg";
  const InviteFrom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: 400,
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
