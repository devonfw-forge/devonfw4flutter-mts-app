import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_order_bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_order_state.dart';
import 'package:my_thai_star_flutter/main.dart';
import 'package:my_thai_star_flutter/ui/router.dart';
import 'package:my_thai_star_flutter/ui/header/authentication_dialog.dart';
import 'package:my_thai_star_flutter/ui/header/locale_dropdown.dart';

///Defines the [AppBar] used by all [Scaffold]s of the app
///
///The [AppBar] property of a [Scaffold] requires a [PreferredSizeWidget].
///That's why we have to implement it here.
class Header extends StatelessWidget implements PreferredSizeWidget {
  static const double _elevation = 20;

  ///This widget appears across the bottom of the app bar.
  ///
  ///Typically a [TabBar]. Only widgets that implement
  ///[PreferredSizeWidget] can be used at the bottom of an app bar.
  final Widget _bottom;
  final double _height;

  const Header({Key key, height = 50.0, bottom})
      : _height = height,
        _bottom = bottom,
        super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(_height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      title: Text(MyThaiStar.title),
      elevation: _elevation,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.person_outline, color: Colors.white),
          onPressed: () => showDialog(
            context: context,
            builder: (BuildContext context) => AuthenticationDialog(),
          ),
        ),
        BlocBuilder<CurrentOrderBloc, CurrentOrderState>(
          builder: (context, state) =>
              _buildBasketIcon(state.numberOfDishes, context),
        ),
        LocaleDropDown(),
      ],
      bottom: _bottom,
    );
  }

  ///Generate a [IconButton] with a [Badge] in the top right corner
  ///
  ///The badge only appears when the [amount] is > 0
  Widget _buildBasketIcon(int amount, BuildContext context) {
    Widget iconButton = IconButton(
      icon: Icon(Icons.shopping_basket, color: Colors.white),
      onPressed: () => Navigator.pushNamed(context, Router.order),
    );

    if (amount == 0) {
      return iconButton;
    } else {
      return Badge(
        badgeContent: Text("$amount", style: TextStyle(color: Colors.white)),
        position: BadgePosition.topRight(top: 1, right: 1),
        badgeColor: Theme.of(context).accentColor,
        child: iconButton,
      );
    }
  }
}
