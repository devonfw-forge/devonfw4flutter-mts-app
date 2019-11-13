import 'package:flutter/material.dart';

///common [AppBar] throughout the App
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  static const String title = "My Thai Star";
  static const double elevation = 20;
  final double height;

  const CustomAppBar({
    Key key,
    this.height = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0.0,
      title: Text(title),
      elevation: elevation,
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.person, color: Colors.white), onPressed: () {}),
        IconButton(
            icon: Icon(Icons.shopping_basket, color: Colors.white),
            onPressed: () {}),
        IconButton(
            icon: Icon(Icons.flag, color: Colors.white), onPressed: () {}),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
