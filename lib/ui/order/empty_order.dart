import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/localization/translation.dart';
import 'package:my_thai_star_flutter/ui/router.dart';
import 'package:my_thai_star_flutter/ui/ui_helper.dart';

///Defines a Message which informs the user that the 
///[OrderPositionList] is empty
///
///The Message is Wrapped in a [SliverToBoxAdapter]
///so it can be displayed in a [CustomScrollView].
class EmptyOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.only(
          top: UiHelper.standard_padding,
          bottom: UiHelper.standard_padding,
          left: UiHelper.standard_padding,
          right: UiHelper.standard_padding,
        ),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.spaceBetween,
          children: <Widget>[
            Text(Translation.of(context).get("sidenav/noSelection")),
            FlatButton(
              padding: EdgeInsets.all(0),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              child: Text(
                Translation.of(context).get("buttons/addToOrder"),
                style: Theme.of(context)
                    .textTheme
                    .button
                    .copyWith(color: Theme.of(context).accentColor),
              ),
              onPressed: () => Navigator.pushNamed(context, Router.menu),
            ),
          ],
        ),
      ),
    );
  }
}