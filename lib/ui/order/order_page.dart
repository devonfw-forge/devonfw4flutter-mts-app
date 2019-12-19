import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_thai_star_flutter/annotations.dart';
import 'package:my_thai_star_flutter/blocs/current_order_bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_order_state.dart';
import 'package:my_thai_star_flutter/ui/order/order_position_list.dart';
import 'package:my_thai_star_flutter/ui/order/empty_order.dart';
import 'package:my_thai_star_flutter/ui/order/order_form.dart';
import 'package:my_thai_star_flutter/ui/order/order_header.dart';
import 'package:my_thai_star_flutter/ui/order/resume_header.dart';
import 'package:my_thai_star_flutter/ui/order/total_price_display.dart';
import 'package:my_thai_star_flutter/ui/header/header.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/app_drawer.dart';

///Defines the layout of the Widgets related to the
///order feature
///
///#### The Order feature from a top-down view
///[Order] in the MyThaStar context means selecting
///[Dish]s and adding them to a [Booking] / Reservation that
///was made. This link happens through a "booking token" that
///the user receives once they place a [Booking] on the [BookingPage]
///
///#### Relevant Blocs for this feature
///[OrderBloc], [CurrentOrderBloc],
///[BookingBloc], [LocalizationBloc]
@TopLevelRoute("/order")
class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      backgroundColor: Colors.white,
      drawer: AppDrawer(),
      //CustomScrollView because it consists of Widgets with different types
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                ResumeHeader(),
                OrderHeader(),
              ],
            ),
          ),
          BlocBuilder<CurrentOrderBloc, CurrentOrderState>(
              builder: (context, state) {
            //Rebuild the OrderPositionList every
            //time the CurrentOrderBloc emits a new state
            if (state.positions.isEmpty) {
              return EmptyOrder();
            } else {
              return OrderPositionList(positions: state.positions);
            }
          }),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                TotalPriceDisplay(),
                OrderForm(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
