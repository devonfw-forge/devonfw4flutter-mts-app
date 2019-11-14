import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/ui/pages/booking/booking_tab.dart';
import 'package:my_thai_star_flutter/ui/ui_helper.dart';

import 'invite_tab.dart';

///[Card] with a [TabBar] that enables the switch between the [BookingForm] &
///the [InviteForm].
///
///Flutter does not have an optimal way to handle [Column]s inside a
///[SingleChildScrollView]. This is because calculating the height of
///child widgets during the rendering of a parent is very work intensive.
///Because of this, it was decided to limit the height of the Forms to
///a fixed value [_TabCardState.maxHeight]. This takes away from the 
///Responsiveness but massively boosts performance.
class TabCard extends StatefulWidget {
  const TabCard({Key key}) : super(key: key);

  @override
  _TabCardState createState() => _TabCardState();
}

class _TabCardState extends State<TabCard> with SingleTickerProviderStateMixin {
  static const double padding = 10;
  static const double maxHeight = 860;

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
              //This is where we limit the Form height
              maxHeight: maxHeight,
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  BookingTab(),
                  InviteTab(),
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
