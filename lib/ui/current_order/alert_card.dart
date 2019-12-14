import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/router.dart';
import 'package:my_thai_star_flutter/ui/ui_helper.dart';

class AlertCard extends StatelessWidget {
  static const double padding = 20;
  static const Color backgroundColor = Color(0xffffe4c4);

  static const String message =
      "To order a menu it is necessary to obtain a booking id" +
          ". Either you enter your already known booking id or you book a table";

  const AlertCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(UiHelper.standart_padding),
      child: Card(
        color: backgroundColor,
        child: Padding(
          padding: EdgeInsets.all(UiHelper.standart_padding),
          child: Row(
            children: <Widget>[
              Icon(Icons.report_problem),
              SizedBox(width: UiHelper.standart_padding),
              Expanded(child: Text(message)),
              SizedBox(width: UiHelper.standart_padding),
              FlatButton(
                child: Text(
                  "Book Table",
                  style: Theme.of(context).textTheme.button.copyWith(
                        color: Theme.of(context).accentColor,
                      ),
                ),
                onPressed: () => Navigator.pushNamed(context, Router.booking),
              )
            ],
          ),
        ),
      ),
    );
  }
}
