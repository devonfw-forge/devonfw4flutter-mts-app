import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/ui/router.dart';
import 'package:my_thai_star_flutter/localization/translation.dart';
import 'package:my_thai_star_flutter/ui/ui_helper.dart';

import 'package:my_thai_star_flutter/ui/home/home_card.dart';

///Column that holds 2 [HomeCard]s
class CardDisplay extends StatelessWidget {
  //Content
  static const String _restaurantImg = 'assets/images/thai-restaurant.jpg';
  static const String _menuImg = 'assets/images/thai-restaurant-dish.jpg';

  //Drop Shadow
  static const double _blur = 6.0;
  static const double _spread = 0.1;
  static const Color _shadowColor = Colors.black54;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(UiHelper.standard_padding),
      decoration: new BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: _shadowColor,
            blurRadius: _blur, // has the effect of softening the shadow
            spreadRadius: _spread, // has the effect of extending the shadow
          )
        ],
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(UiHelper.borderRadius)),
      ),
      child: Column(
        children: <Widget>[
          HomeCard(
            imageLocation: _restaurantImg,
            text: Translation.of(context).get("home/restaurantContent"),
            headline: Translation.of(context).get("home/restaurantTitle"),
            buttonLabel: Translation.of(context).get("buttons/bookTable"),
            onPressed: () => Navigator.pushNamed(context, Router.booking),
          ),
          HomeCard(
            imageLocation: _menuImg,
            text: Translation.of(context).get("home/menuContent"),
            headline: Translation.of(context).get("home/menuTitle"),
            buttonLabel: Translation.of(context).get("buttons/viewMenu"),
            onPressed: () => Navigator.pushNamed(context, Router.menu),
          ),
        ],
      ),
    );
  }
}
