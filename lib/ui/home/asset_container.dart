import 'package:flutter/material.dart';

///Defines a [Container] with a given background [AssetImage]
///
///Removes some of the boilerplate when using multiple
///[Container]s in a [Stack].
class AssetContainer extends StatelessWidget {
  final String _assetLocation;
  final BoxFit _fit;
  final double _height;

  const AssetContainer({@required assetLocation, @required fit, height})
      : _assetLocation = assetLocation,
        _fit = fit,
        _height = height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(_assetLocation),
          fit: _fit,
        ),
      ),
    );
  }
}
