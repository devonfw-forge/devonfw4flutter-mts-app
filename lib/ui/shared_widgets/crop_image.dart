import 'package:flutter/material.dart';
import 'dart:convert';

///Crops provided [Image] to cover a given height
///
///The [Image] can be loaded form assets or read
///form an encoded [String]. If no [Image] is 
///provided, a default [Image] is loaded from
///assets.
class CropImage extends StatelessWidget {
  final String _encodedImage;
  final String _assetImage;
  final double _imageHeight;

  const CropImage({
    Key key,
    imageHeight = 300.0,
    encodedImage,
    assetImage = 'assets/images/thai-restaurant.jpg',
  })  : _imageHeight = imageHeight,
        _assetImage = assetImage,
        _encodedImage = encodedImage,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _imageHeight,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: _encodedImage == null
              ? AssetImage(_assetImage)
              : Image.memory(base64Decode(_encodedImage)).image,
        ),
      ),
    );
  }
}
