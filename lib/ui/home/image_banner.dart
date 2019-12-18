import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/main.dart';
import 'package:my_thai_star_flutter/ui/home/asset_container.dart';
import 'package:my_thai_star_flutter/blocs/localization_bloc.dart';

///The Banner at the very top of the [home]-page
class ImageBanner extends StatelessWidget {
  static const double _fullHeight = 220;
  static const double _starHeight = 80;
  static const int _textSpacerFlex = 2;
  static const String _woodImg = "assets/images/Wood2.jpg";
  static const String _dishImg = "assets/images/background-dish.png";
  static const String _starImg = "assets/images/star.png";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _fullHeight,
      child: Stack(
        children: <Widget>[
          AssetContainer(
            assetLocation: _woodImg,
            fit: BoxFit.fill,
          ),
          AssetContainer(
            assetLocation: _dishImg,
            fit: BoxFit.fitHeight,
          ),
          AssetContainer(
            height: _starHeight,
            assetLocation: _starImg,
            fit: BoxFit.fitHeight,
          ),
          Container(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Spacer(),
                Text(
                  MyThaiStar.title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline,
                ),
                Text(
                  LocalizationBloc.of(context).get("home/subtitle"),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle,
                ),
                Spacer(flex: _textSpacerFlex),
              ],
            ),
          )
        ],
      ),
    );
  }
}
