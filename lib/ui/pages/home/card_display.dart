import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/ui/ui_helper.dart';

import 'home_card.dart';

///Column tht holds 2 [HomeCard]s
class CardDisplay extends StatelessWidget {
  static const double margin = 10;
  static const double padding = 10;

  //Content
  static const String restaurantImg = 'assets/images/thai-restaurant.jpg';
  static const String menuImg = 'assets/images/thai-restaurant-dish.jpg';
  static const String placeHolderText = 'Lorem ipsum dolor sit amet, consectetur ' +
      'adipiscing elit. Praesent elementum tellus eget volutpat porta. Duis pellentesque' +
      ' velit venenatis, tincidunt ligula ac, rhoncus felis. Donec aliquam nulla id turpis' +
      ' dignissim laoreet. Vestibulum sit amet ante eu lacus convallis lobortis sit amet eu' +
      ' orci. Nam vitae felis ac nisi accumsan faucibus.';

  //Drop Shadow
  static const double blur = 6.0;
  static const double spread = 0.1;

  const CardDisplay({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(
        left: margin,
        right: margin,
        bottom: margin,
      ),
      padding: EdgeInsets.all(padding),
      decoration: new BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: blur, // has the effect of softening the shadow
            spreadRadius: spread, // has the effect of extending the shadow
          )
        ],
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(UiHelper.borderRadius)),
      ),
      child: Column(
        children: <Widget>[
          HomeCard(
            imageLocation: restaurantImg,
            text: placeHolderText,
            headline: 'OUR RESTAURANT',
            buttonLable: 'BOOK TABLE',
            onPressed: () {},
          ),
          HomeCard(
            imageLocation: menuImg,
            text: placeHolderText,
            headline: 'OUR MENU',
            buttonLable: 'VIEW MENU',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
