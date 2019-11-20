import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/ui/ui_helper.dart';

class TotalPriceDisplay extends StatelessWidget {
  const TotalPriceDisplay({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(UiHelper.standart_padding),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Total",
            style:
                Theme.of(context).textTheme.title.copyWith(color: Colors.black),
          ),
          Text(
            "27.00 €",
            style:
                Theme.of(context).textTheme.title.copyWith(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
