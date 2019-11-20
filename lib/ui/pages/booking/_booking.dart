import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/ui/pages/booking/custom_form_card.dart';
import 'package:my_thai_star_flutter/ui/pages/booking/invite_form.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/app_drawer.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/custom_app_bar.dart';

class Booking extends StatelessWidget {
  static const bookingImage = "assets/images/slider-1.jpg";
  static const inviteImage = "assets/images/slider-2.jpg";
  static const double appBarHeight = 110;
  static const List<Tab> tabs = <Tab>[
    Tab(text: 'Book a Table'),
    Tab(text: 'Invite Friends'),
  ];

  Booking({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
          appBar: CustomAppBar(
            height: appBarHeight,
            bottom: TabBar(
              tabs: tabs,
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              labelStyle: Theme.of(context).textTheme.title,
            ),
          ),
          backgroundColor: Theme.of(context).backgroundColor,
          drawer: AppDrawer(),
          body: TabBarView(
            children: <Widget>[
              CustomFormCard(
                title: "BOOK YOUR TABLE",
                subTitle: "You can book a table and an order menu",
                headerImageLocation: bookingImage,
                form: InviteForm(),
              ),
              CustomFormCard(
                title: "ADD YOUR INFORMATION AND FRIENDS",
                headerImageLocation: inviteImage,
                form: InviteForm(),
              ),
            ],
          )),
    );
  }
}
