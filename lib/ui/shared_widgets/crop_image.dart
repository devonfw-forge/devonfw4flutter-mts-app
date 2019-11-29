import 'package:flutter/material.dart';
import 'dart:convert';

///Crops Image from assets to cover a given height
///
///Default [CropImage.imageHeight] is 400
class CropImage extends StatelessWidget {
  final String encodedImage;
  final String assetImage;
  final double imageHeight;
  const CropImage({
    Key key,
    this.imageHeight = 300,
    this.encodedImage,
    this.assetImage = 'assets/images/thai-restaurant.jpg',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: imageHeight,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: encodedImage == null
              ? AssetImage(assetImage)
              : Image.memory(base64Decode(encodedImage)).image,
        ),
      ),
    );
  }
}
