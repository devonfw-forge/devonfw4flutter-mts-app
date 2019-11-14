import 'package:flutter/material.dart';

class FormHead extends StatelessWidget {
  final String imageLocation;
  final double imageHeight;
  const FormHead({
    Key key,
    @required this.imageLocation,
    this.imageHeight = 400,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: imageHeight,
      decoration: BoxDecoration(
          image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage(imageLocation),
      )),
    );
  }
}
