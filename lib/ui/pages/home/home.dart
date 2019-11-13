import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/app_drawer.dart';

import 'card_display.dart';
import 'image_banner.dart';

///Landing Page of the App
///
///Gives navigation to menu and booking-page
class Home extends StatelessWidget {
  static const double cardDisplayTopPadding = 180;
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            ImageBanner(),
            Padding(
                child: CardDisplay(),
                padding: EdgeInsets.only(top: cardDisplayTopPadding)),
          ],
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      titleSpacing: 0.0,
      title: Text("My Thai Star"),
      elevation: 20,
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
}
