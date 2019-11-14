import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/crop_image.dart';
import 'package:my_thai_star_flutter/ui/ui_helper.dart';

class CustomFormCard extends StatelessWidget {
  final String headerImageLocation;
  final List<Widget> children;
  const CustomFormCard({
    Key key,
    @required this.headerImageLocation,
    @required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(UiHelper.standart_padding),
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: UiHelper.elevation,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CropImage(
                imageLocation: headerImageLocation,
              ),
              Padding(
                  padding: EdgeInsets.all(UiHelper.card_margin),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: children,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
