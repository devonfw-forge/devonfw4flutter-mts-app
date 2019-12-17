import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/router.dart';
import 'package:my_thai_star_flutter/ui/mts-localization.dart';

///Global [Drawer] that helps navigate to the 3 main pages of the App.
///
///Navigation to: Home, Menu and Book Table - Pages
class AppDrawer extends StatelessWidget {
  static const double topMargin = 30;
  static const String homeRoute = Router.home;
  static const String bookRoute = Router.booking;
  static const String menuRoute = Router.menu;

  const AppDrawer();

  @override
  Widget build(BuildContext context) {
    String currentRoute = ModalRoute.of(context).settings.name;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(height: topMargin),
          _DrawerObject(
            title: MtsLocalization.of(context).get("main/home"),
            icon: Icons.home,
            selected: currentRoute == homeRoute,
            onTap: () => Navigator.pushNamed(context, homeRoute),
          ),
          _DrawerObject(
            title: MtsLocalization.of(context).get("main/book"),
            icon: Icons.bookmark,
            selected: currentRoute == bookRoute,
            onTap: () => Navigator.pushNamed(context, bookRoute),
          ),
          _DrawerObject(
            title: MtsLocalization.of(context).get("main/menu"),
            icon: Icons.restaurant_menu,
            selected: currentRoute == menuRoute,
            onTap: () => Navigator.pushNamed(context, menuRoute),
          ),
        ],
      ),
    );
  }
}

///One item in the [AppDrawer]
class _DrawerObject extends StatelessWidget {
  static const double iconSize = 30;
  final String title;
  final bool selected;
  final IconData icon;
  final VoidCallback onTap;

  const _DrawerObject({
    this.title = "EMPTY",
    this.icon = Icons.error,
    this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: selected,
      leading: Icon(icon, size: iconSize),
      title: Text(title, style: Theme.of(context).textTheme.title),
      onTap: onTap,
    );
  }
}
