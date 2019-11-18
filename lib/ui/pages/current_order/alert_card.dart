import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/ui/ui_helper.dart';

class AlertCard extends StatelessWidget {
  const AlertCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: Card(
        elevation: UiHelper.elevation,
        color: Color(0xffffe4c4),
        child: Padding(
          padding: const EdgeInsets.all(UiHelper.standart_padding),
          child: Row(
            children: <Widget>[
              Icon(Icons.report_problem),
              SizedBox(width: UiHelper.standart_padding),
              Expanded(
                child: Text(
                    "To order a menu it is necessary to obtain a booking id" +
                        ". Either you enter your already known booking id or you book a table"),
              ),
              SizedBox(width: UiHelper.standart_padding),
              FlatButton(
                child: Text(
                  "Book Table",
                  style: Theme.of(context).textTheme.button.copyWith(
                        color: Theme.of(context).accentColor,
                      ),
                ),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
