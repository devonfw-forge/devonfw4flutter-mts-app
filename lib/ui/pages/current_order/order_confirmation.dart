import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/ui/pages/current_order/alert_card.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/labeled_checkbox.dart';
import 'package:my_thai_star_flutter/ui/ui_helper.dart';

class OrderConfirmation extends StatelessWidget {
  const OrderConfirmation({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AlertCard(),
        Padding(
          padding: const EdgeInsets.only(
            right: UiHelper.standart_padding,
            left: UiHelper.standart_padding,
          ),
          child: TextField(
            decoration: InputDecoration(
              labelText: "Booking ID",
            ),
          ),
        ),
        LabeledCheckBox(
          label: "Accept Terms",
          state: false,
          onStateChange: (bool) {},
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FlatButton(
              child: Text(
                "CANCEL",
                style: Theme.of(context).textTheme.button.copyWith(
                      color: Colors.grey,
                    ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            SizedBox(width: UiHelper.standart_padding),
            FlatButton(
              child: Text(
                "SEND",
                style: Theme.of(context).textTheme.button.copyWith(
                      color: Theme.of(context).accentColor,
                    ),
              ),
              onPressed: () {},
            ),
          ],
        )
      ],
    );
  }
}
