import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/ui/booking/booking_form.dart';
import 'package:my_thai_star_flutter/ui/booking/custom_form_card.dart';
import 'package:my_thai_star_flutter/ui/header/header.dart';
import 'package:my_thai_star_flutter/blocs/localization_bloc.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/app_drawer.dart';

class BookingPage extends StatelessWidget {
  static const bookingImage = "assets/images/slider-1.jpg";
  static const inviteImage = "assets/images/slider-2.jpg";
  static const double appBarHeight = 110;

  BookingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Tab> tabs = <Tab>[
      Tab(text: LocalizationBloc.of(context).get("buttons/bookTable")),
      Tab(text: LocalizationBloc.of(context).get("buttons/inviteFriends")),
    ];

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: Header(
          height: appBarHeight,
          bottom: TabBar(
            tabs: tabs,
            indicatorColor: Colors.white,
            labelStyle: Theme.of(context).textTheme.title,
          ),
        ),
        drawer: AppDrawer(),
        body: TabBarView(
          children: <Widget>[
            CustomFormCard(
              title: LocalizationBloc.of(context).get("bookTable/bookingTitle"),
              subTitle: LocalizationBloc.of(context).get("bookTable/bookingSubtitle"),
              headerImageLocation: bookingImage,
              form: BookingForm(),
            ),
            CustomFormCard(
              title: LocalizationBloc.of(context).get("bookTable/reservationTitle"),
              headerImageLocation: inviteImage,
              form: BookingForm(),
            ),
          ],
        ),
      ),
    );
  }
}
