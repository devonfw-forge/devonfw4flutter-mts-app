import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_order_bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_order_state.dart';
import 'package:my_thai_star_flutter/ui/order/dish_slip_list.dart';
import 'package:my_thai_star_flutter/ui/order/empty_order.dart';
import 'package:my_thai_star_flutter/ui/order/order_form.dart';
import 'package:my_thai_star_flutter/ui/order/order_header.dart';
import 'package:my_thai_star_flutter/ui/order/resume_header.dart';
import 'package:my_thai_star_flutter/ui/order/total_price_display.dart';
import 'package:my_thai_star_flutter/ui/header/header.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/app_drawer.dart';

class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      backgroundColor: Colors.white,
      drawer: AppDrawer(),
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
            if (state.dishMap.isEmpty) {
              return EmptyOrder();
            } else {
              return DishSlipList(dishes: state.dishMap);
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

