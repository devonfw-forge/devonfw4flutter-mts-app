import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/models/dish.dart';
import 'package:my_thai_star_flutter/ui/pages/current_order/dish_slip.dart';
import 'package:my_thai_star_flutter/ui/ui_helper.dart';

class DishSlipList extends StatelessWidget {
  const DishSlipList({
    Key key,
    @required this.dishes,
  }) : super(key: key);

  final List<Dish> dishes;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(UiHelper.standart_padding),
            alignment: Alignment.topLeft,
            child: Text(
              "ORDER MENU",
              style: Theme.of(context)
                  .textTheme
                  .title
                  .copyWith(color: Colors.black),
            ),
          ),
          Divider(
            color: Colors.grey,
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey,
              ),
              itemCount: dishes.length,
              itemBuilder: (BuildContext context, int index) {
                return DishSlip(dish: dishes[index]);
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(UiHelper.standart_padding),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Total",
                  style: Theme.of(context)
                      .textTheme
                      .title
                      .copyWith(color: Colors.black),
                ),
                Text(
                  "27.00 €",
                  style: Theme.of(context)
                      .textTheme
                      .title
                      .copyWith(color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

