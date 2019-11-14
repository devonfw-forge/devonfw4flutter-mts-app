import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/crop_image.dart';

import '../../ui_helper.dart';
import 'invite_form.dart';


class InviteTab extends StatefulWidget {
  const InviteTab({Key key}) : super(key: key);

  @override
  _InviteFromState createState() => _InviteFromState();
}

class _InviteFromState extends State<InviteTab> {
  static const imageLocation = "assets/images/slider-2.jpg";

 @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        CropImage(
          imageLocation: imageLocation,
        ),
        Padding(
            padding: const EdgeInsets.all(UiHelper.card_margin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "ADD YOUR INFORMATION AND FRIENDS",
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.title.copyWith(
                      color: Colors.black, fontWeight: FontWeight.normal),
                ),
                InviteForm(),
              ],
            )),
      ],
    );
  }
}
