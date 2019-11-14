import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/ui/pages/booking/booking_tab.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/app_drawer.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/custom_app_bar.dart';
import 'package:my_thai_star_flutter/ui/ui_helper.dart';

import 'invite_tab.dart';

class Booking extends StatelessWidget {
  Booking({Key key}) : super(key: key);

  final List<Tab> tabs = <Tab>[
    Tab(text: 'Book a Table'),
    Tab(text: 'Invite Friends'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
          appBar: CustomAppBar(
            height: 110,
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
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(UiHelper.standart_padding),
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        elevation: UiHelper.elevation,
                        child: BookingTab(),
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(UiHelper.standart_padding),
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        elevation: UiHelper.elevation,
                        child: InviteTab(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
