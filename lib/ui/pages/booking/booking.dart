import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/ui/pages/booking/tab_card.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/app_drawer.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/custom_app_bar.dart';

class Booking extends StatelessWidget {
  static const double textPadding = 10;

  const Booking({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        backgroundColor: Theme.of(context).backgroundColor,
        drawer: AppDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(textPadding),
                child: Text(
                  "You can invite your friends to lunch or book a table",
                  style: Theme.of(context).textTheme.title,
                  textAlign: TextAlign.center,
                ),
              ),
              TabCard(),
            ],
          ),
        ));
  }
}
