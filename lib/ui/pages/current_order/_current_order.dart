import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_order_bloc.dart';
import 'package:my_thai_star_flutter/models/dish.dart';
import 'package:my_thai_star_flutter/ui/pages/current_order/dish_slip.dart';
import 'package:my_thai_star_flutter/ui/pages/current_order/order_confirmation.dart';
import 'package:my_thai_star_flutter/ui/pages/current_order/order_list_header.dart';
import 'package:my_thai_star_flutter/ui/pages/current_order/resume_header.dart';
import 'package:my_thai_star_flutter/ui/pages/current_order/total_price_display.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/app_drawer.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/custom_app_bar.dart';

class CurrentOrder extends StatelessWidget {
  CurrentOrder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: Colors.white,
      drawer: AppDrawer(),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                ResumeHeader(),
                OrderListHeader(),
              ],
            ),
          ),
          BlocBuilder<CurrentOrderBloc, List<Dish>>(
            builder: (context, dishes) => SliverList(
              delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) =>
                      DishSlip(dish: dishes[index]),
                  childCount: dishes.length),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                TotalPriceDisplay(),
                OrderConfirmation(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
