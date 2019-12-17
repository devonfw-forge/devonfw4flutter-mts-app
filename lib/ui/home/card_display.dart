import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/router.dart';
import 'package:my_thai_star_flutter/ui/mts-localization.dart';
import 'package:my_thai_star_flutter/ui/ui_helper.dart';

import 'package:my_thai_star_flutter/ui/home/home_card.dart';

///Column that holds 2 [HomeCard]s
class CardDisplay extends StatelessWidget {
  //Content
  static const String restaurantImg = 'assets/images/thai-restaurant.jpg';
  static const String menuImg = 'assets/images/thai-restaurant-dish.jpg';
  
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
      margin: EdgeInsets.all(UiHelper.standard_padding),
      decoration: new BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
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
            text: MtsLocalization.of(context).get("home/restaurantContent"),
            headline: MtsLocalization.of(context).get("home/restaurantTitle"),
            buttonLabel: MtsLocalization.of(context).get("buttons/bookTable"),
            onPressed: () => Navigator.pushNamed(context, Router.booking),
          ),
          HomeCard(
            imageLocation: menuImg,
            text: MtsLocalization.of(context).get("home/menuContent"),
            headline: MtsLocalization.of(context).get("home/menuTitle"),
            buttonLabel: MtsLocalization.of(context).get("buttons/viewMenu"),
            onPressed: () => Navigator.pushNamed(context, Router.menu),
          ),
        ],
      ),
    );
  }
}
