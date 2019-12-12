import 'dart:collection';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_thai_star_flutter/features/current_order/blocs/current_order_bloc.dart';
import 'package:my_thai_star_flutter/features/menu/models/dish.dart';
import 'package:my_thai_star_flutter/router.dart';
import 'package:my_thai_star_flutter/shared_widgets/authentication_alert.dart';

///common [AppBar] throughout the App
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  static const String title = "My Thai Star";
  static const double elevation = 20;
  final double height;
  final Widget bottom;

  const CustomAppBar({
    Key key,
    this.height = 50,
    this.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0.0,
      title: Text(title),
      elevation: elevation,
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.person_outline, color: Colors.white),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => AuthenticationAlert(),
              );
            }),
        BlocBuilder<CurrentOrderBloc, LinkedHashMap<Dish, int>>(
          builder: (context, dishes) => _buildBasketIcon(dishes, context),
        ),
        IconButton(
            icon: Icon(Icons.flag, color: Colors.white), onPressed: () {}),
      ],
      bottom: bottom,
    );
  }

  Widget _buildBasketIcon(Map<Dish, int> dishes, BuildContext context) {
    int amount = getOrderAmount(dishes);

    Widget iconButton = IconButton(
      icon: Icon(Icons.shopping_basket, color: Colors.white),
      onPressed: () => Navigator.pushNamed(context, Router.currentOrder),
    );

    if (amount == 0) {
      return iconButton;
    } else {
      return Badge(
        badgeContent: Text(
          "$amount",
          style: TextStyle(color: Colors.white),
        ),
        position: BadgePosition.topRight(top: 1, right: 1),
        badgeColor: Theme.of(context).accentColor,
        child: iconButton,
      );
    }
  }

  @override
  Size get preferredSize => Size.fromHeight(height);

  int getOrderAmount(Map<Dish, int> dishes) {
    int amount = 0;
    dishes.forEach((d, i) => amount += i);
    return amount;
  }
}
