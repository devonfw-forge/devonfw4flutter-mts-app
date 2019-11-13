import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/ui/pages/booking/booking_form.dart';
import 'package:my_thai_star_flutter/ui/pages/booking/invite_form.dart';
import 'package:my_thai_star_flutter/ui/ui_helper.dart';

class TabCard extends StatefulWidget {
  const TabCard({Key key}) : super(key: key);

  @override
  _TabCardState createState() => _TabCardState();
}

class _TabCardState extends State<TabCard> with SingleTickerProviderStateMixin {
  static const double padding = 10;
  static const double maxHeight = 800;

  final List<Tab> tabs = <Tab>[
    Tab(text: 'Book a Table'),
    Tab(text: 'Invite Friends'),
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(padding),
      child: Card(
        elevation: UiHelper.elevation,
        child: Column(
          children: <Widget>[
            TabBar(
              tabs: tabs,
              controller: _tabController,
              indicatorColor: Colors.black,
              labelColor: Colors.grey,
              labelStyle: Theme.of(context).textTheme.title,
            ),
            LimitedBox(
              maxHeight: maxHeight,
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  BookingFrom(),
                  InviteFrom(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
