import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/models/dish.dart';

class DishSlip extends StatelessWidget {
  static const double textDistance = 3;
  final Dish dish;

  const DishSlip({Key key, @required this.dish}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.cancel),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Wrap(
                  children: <Widget>[
                    Text(
                      dish.name,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle
                          .copyWith(color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(height: textDistance),
                Text(
                  "${dish.extras}".replaceAll(RegExp(r"[\[\]]"), ""),
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: textDistance),
                Text(
                  "Add Comment",
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.remove),
          ),
          Text(
            "1",
            style: Theme.of(context)
                .textTheme
                .subtitle
                .copyWith(color: Colors.grey),
          ),
          IconButton(
            icon: Icon(
              Icons.add,
              color: Theme.of(context).accentColor,
            ),
          ),
          Text(
            "${dish.price} €",
            style: Theme.of(context)
                .textTheme
                .subtitle
                .copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
