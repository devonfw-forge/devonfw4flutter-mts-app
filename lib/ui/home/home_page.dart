import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/ui/header/header.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/app_drawer.dart';

import 'package:my_thai_star_flutter/ui/home/card_display.dart';
import 'package:my_thai_star_flutter/ui/home/image_banner.dart';

///Landing Page of the App
///
///Gives navigation to menu and booking-page
class HomePage extends StatelessWidget {
  static const double _cardDisplayTopPadding = 170;
  final String _title;

  const HomePage({Key key, @required title})
      : _title = title,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: _title),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            ImageBanner(title: _title),
            Padding(
                child: CardDisplay(),
                padding: EdgeInsets.only(top: _cardDisplayTopPadding)),
          ],
        ),
      ),
    );
  }
}
