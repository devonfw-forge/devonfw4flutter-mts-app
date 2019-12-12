import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/ui_helper.dart';

class OrderListHeader extends StatelessWidget {
  const OrderListHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(UiHelper.standart_padding),
          alignment: Alignment.topLeft,
          child: Text(
            "ORDER MENU",
            style:
                Theme.of(context).textTheme.title.copyWith(color: Colors.black),
          ),
        ),
        Divider(color: Colors.grey),
      ],
    );
  }
}
