import 'package:flutter/material.dart';

///A [Container] with a background Asset
///
///Removes some of the boilerplate when using multiple
///[Container]s in a [Stack].
class AssetContainer extends StatelessWidget {
  final double height;
  final String assetLocation;
  final BoxFit fit;
  const AssetContainer({
    @required this.assetLocation,
    this.height,
    @required this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(assetLocation),
          fit: fit,
        ),
      ),
    );
  }
}
