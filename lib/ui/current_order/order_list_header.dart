import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/blocs/localization_bloc.dart';
import 'package:my_thai_star_flutter/ui/ui_helper.dart';

class OrderListHeader extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(UiHelper.standard_padding),
          alignment: Alignment.topLeft,
          child: Text(LocalizationBloc.of(context).get("sidenav/header"),
              style: Theme.of(context)
                  .textTheme
                  .title
                  .copyWith(color: Colors.black)),
        ),
        Divider(color: Colors.grey),
      ],
    );
  }
}
