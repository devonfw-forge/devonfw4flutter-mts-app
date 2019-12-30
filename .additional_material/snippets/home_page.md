````dart
import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/annotation.dart';
import 'package:my_thai_star_flutter/ui/header/header.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/app_drawer.dart';

import 'package:my_thai_star_flutter/ui/home/card_display.dart';
import 'package:my_thai_star_flutter/ui/home/image_banner.dart';

///Defines the top-level layout of the Widgets related to the
///home page
///
///The [HomePage] is the first thing a user sees when opening 
///up MyThaiStar. It provides access to all other pages of the
///Application.
///
///#### Relevant Blocs for this feature:
///[LocalizationBloc]
@TopLevelRoute('/')
class HomePage extends StatelessWidget {
  static const double _cardDisplayTopPadding = 170;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            ImageBanner(),
            Padding(
                child: CardDisplay(),
                padding: EdgeInsets.only(top: _cardDisplayTopPadding)),
          ],
        ),
      ),
    );
  }
}
````