import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/authentication_alert.dart';

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
              showDialog(context: context, builder: (BuildContext context) {
                return AuthenticationAlert();
              },);
            }),
        IconButton(
            icon: Icon(Icons.shopping_basket, color: Colors.white),
            onPressed: () {}),
        IconButton(
            icon: Icon(Icons.flag, color: Colors.white), onPressed: () {}),
      ],
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
