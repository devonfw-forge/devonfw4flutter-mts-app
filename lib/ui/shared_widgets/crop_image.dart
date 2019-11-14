import 'package:flutter/material.dart';

///Crops Image from assets to cover a given height 
///
///Default [CropImage.imageHeight] is 400
class CropImage extends StatelessWidget {
  final String imageLocation;
  final double imageHeight;
  const CropImage({
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
