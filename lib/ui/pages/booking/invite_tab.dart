import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/crop_image.dart';


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
      children: <Widget>[CropImage(imageLocation: imageLocation)],
    );
  }
}
