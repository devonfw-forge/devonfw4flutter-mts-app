import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/ui/pages/booking/tab_card.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/app_drawer.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/custom_app_bar.dart';
import 'package:my_thai_star_flutter/ui/ui_helper.dart';

///Gives the option to book a table and invite friends to
///a booked reservation
///
///Holds Headline and the [TabCard]
class Booking extends StatelessWidget {
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
                padding: const EdgeInsets.all(UiHelper.standart_padding),
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
