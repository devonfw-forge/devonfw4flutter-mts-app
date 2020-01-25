import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/ui/router.dart';
import 'package:my_thai_star_flutter/ui/localization.dart';
import 'package:my_thai_star_flutter/ui/ui_helper.dart';

///Defines a [Card] which informs the user that no booking token
///has been entered
///
///The [AlertCard] also has a button that navigates the user
///to the [Router.booking] [Route].
class AlertCard extends StatelessWidget {
  static const Color _backgroundColor = Color(0xffffe4c4);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(UiHelper.standard_padding),
      child: Card(
        color: _backgroundColor,
        child: Padding(
          padding: EdgeInsets.all(UiHelper.standard_padding),
          child: Row(
            children: <Widget>[
              Icon(Icons.report_problem),
              SizedBox(width: UiHelper.standard_padding),
              Expanded(
                child: Text(Translation.of(context).get('alerts/orderID')),
              ),
              SizedBox(width: UiHelper.standard_padding),
              FlatButton(
                child: Text(
                  Translation.of(context).get('buttons/bookTable'),
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(color: Theme.of(context).accentColor),
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
