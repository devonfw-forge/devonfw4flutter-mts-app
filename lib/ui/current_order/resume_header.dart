import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/ui/ui_helper.dart';

class ResumeHeader extends StatelessWidget {
  const ResumeHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(UiHelper.standart_padding),
      decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
          Text(
            "RESUME BOOKING",
            style: Theme.of(context)
                .textTheme
                .subtitle
                .copyWith(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
