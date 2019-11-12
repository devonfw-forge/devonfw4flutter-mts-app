import 'package:flutter/material.dart';

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
