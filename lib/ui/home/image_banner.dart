import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/ui/home/asset_container.dart';
import 'package:my_thai_star_flutter/ui/mts-localization.dart';

///The Banner at the very top of the [home]-page
class ImageBanner extends StatelessWidget {
  static const double full_height = 220;
  static const double star_height = 80;
  static const int text_spacer_flex = 2;
  static const String wood_img = "assets/images/Wood2.jpg";
  static const String dish_img = "assets/images/background-dish.png";
  static const String star_img = "assets/images/star.png";

  const ImageBanner({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: full_height,
      child: Stack(
        children: <Widget>[
          AssetContainer(
            assetLocation: wood_img,
            fit: BoxFit.fill,
          ),
          AssetContainer(
            assetLocation: dish_img,
            fit: BoxFit.fitHeight,
          ),
          AssetContainer(
            height: star_height,
            assetLocation: star_img,
            fit: BoxFit.fitHeight,
          ),
          Container(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Spacer(),
                Text(
                  "My Thai Star",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline,
                ),
                Text(
                  MtsLocalization.of(context).map["home"]["subtitle"],
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle,
                ),
                Spacer(flex: text_spacer_flex),
              ],
            ),
          )
        ],
      ),
    );
  }
}
