import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/annotation.dart';
import 'package:my_thai_star_flutter/ui/booking/booking_form.dart';
import 'package:my_thai_star_flutter/ui/booking/form_card.dart';
import 'package:my_thai_star_flutter/ui/header/header.dart';
import 'package:my_thai_star_flutter/ui/localization.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/app_drawer.dart';

///Defines the top-level layout of the Widgets related to the
///booking feature
///
///#### The Booking feature from a top-down view:
///Users can book tables at the My Thai Star restaurant.
///A given [Booking] requires a set of authentication information and a Date.
///Once all required information is collected, the booking
///Request can be send to an external API. If everything is in order,
///a booking token is returned that can be used to order dishes for
///that [Booking].
///
///#### Limitations:
///The 'Invite a Friend' use-case has not been implemented, so
///for now that form is just a copy of the [BookingForm].
///
///#### Relevant Blocs for this feature:
///[BookingBloc], [BookingFormBloc], [LocalizationBloc]
@TopLevelRoute('/booking')
@notFullyImplemented
class BookingPage extends StatelessWidget {
  static const double _appBarHeight = 110;

  //Content
  static const _bookingImage = 'assets/images/slider-1.jpg';
  static const _inviteImage = 'assets/images/slider-2.jpg';

  @override
  Widget build(BuildContext context) {
    //Tabs aren't members, because they need context fo the localized text
    List<Tab> tabs = _buildTabs(context);

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: Header(
          height: _appBarHeight,
          bottom: TabBar(
            tabs: tabs,
            indicatorColor: Colors.white,
            labelStyle: Theme.of(context).textTheme.title,
          ),
        ),
        drawer: AppDrawer(),
        body: TabBarView(
          children: <Widget>[
            FormCard(
              title: Translation.of(context).get('bookTable/bookingTitle'),
              subTitle:
                  Translation.of(context).get('bookTable/bookingSubtitle'),
              headerImageLocation: _bookingImage,
              form: BookingForm(),
            ),
            FormCard(
              title: Translation.of(context).get('bookTable/reservationTitle'),
              headerImageLocation: _inviteImage,
              form: BookingForm(),
            ),
          ],
        ),
      ),
    );
  }

  List<Tab> _buildTabs(BuildContext context) => [
        Tab(text: Translation.of(context).get('buttons/bookTable')),
        Tab(text: Translation.of(context).get('buttons/inviteFriends')),
      ];
}
