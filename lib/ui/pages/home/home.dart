import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/app_drawer.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/custom_app_bar.dart';

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
      appBar: CustomAppBar(),
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
}
