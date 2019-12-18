import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_order_bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_order_state.dart';
import 'package:my_thai_star_flutter/blocs/localization_bloc.dart';
import 'package:my_thai_star_flutter/blocs/localization_state.dart';
import 'package:my_thai_star_flutter/main.dart';
import 'package:my_thai_star_flutter/router.dart';
import 'package:my_thai_star_flutter/ui/header/authentication_dialog.dart';

///common [AppBar] throughout the App
class Header extends StatelessWidget implements PreferredSizeWidget {
  static const double _elevation = 20;
  static const double _paddingRight = 15;
  static const double _distanceOfFlagToOtherIcons = 10;
  static const double _flagHeight = 15;

  final double _height;
  final Widget _bottom;

  const Header({Key key, height = 50, bottom})
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
              _buildBasketIcon(state.numberOfDishes(), context),
        ),
        BlocBuilder<LocalizationBloc, LocalizationState>(
          builder: (context, state) => Padding(
            padding: EdgeInsets.only(
              right: _paddingRight,
              left: _distanceOfFlagToOtherIcons,
            ),
            child: Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Theme.of(context).backgroundColor,
              ),
              child: DropdownButton<String>(
                underline: SizedBox(),
                iconSize: 0.0,
                value: state.languageCode,
                items: _mapDropDownItems(context),
                onChanged: (String locale) =>
                    BlocProvider.of<LocalizationBloc>(context)
                        .dispatch(Locale(locale)),
              ),
            ),
          ),
        ),
      ],
      bottom: _bottom,
    );
  }

  List<DropdownMenuItem<String>> _mapDropDownItems(BuildContext context) {
    return LocalizationBloc.supportedLanguages.map<DropdownMenuItem<String>>(
      (String code) {
        String assetName = code;
        if (code == "en") assetName = "gb";

        return DropdownMenuItem<String>(
          value: code,
          child: Center(
            child: Image.asset(
              'icons/flags/png/$assetName.png',
              package: 'country_icons',
              height: _flagHeight,
            ),
          ),
        );
      },
    ).toList();
  }

  Widget _buildBasketIcon(int amount, BuildContext context) {
    Widget iconButton = IconButton(
      icon: Icon(Icons.shopping_basket, color: Colors.white),
      onPressed: () => Navigator.pushNamed(context, Router.currentOrder),
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
