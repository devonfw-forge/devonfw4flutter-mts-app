import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/router.dart';

///Global [Drawer] that helps navigate to the 3 main pages of the App.
///
///Navigation to: Home, Menu and Book Table - Pages
class AppDrawer extends StatelessWidget {
  static const double topMargin = 30;
  const AppDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(height: topMargin),
          _DrawerObject(
            title: 'HOME',
            icon: Icons.home,
            onTap: () => Navigator.pushNamed(context, Router.home),
          ),
          _DrawerObject(
            title: 'MENU',
            icon: Icons.restaurant_menu,
            onTap: () => Navigator.pushNamed(context, Router.home),
          ),
          _DrawerObject(
            title: 'BOOK TABLE',
            icon: Icons.bookmark,
            onTap: () => Navigator.pushNamed(context, Router.booking),
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
  final IconData icon;
  final VoidCallback onTap;

  const _DrawerObject({
    this.title = "EMPTY",
    this.icon = Icons.error,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: iconSize),
      title: Text(title, style: Theme.of(context).textTheme.title),
      onTap: onTap,
    );
  }
}
