import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/ui/ui_helper.dart';

///Defines a [CircularProgressIndicator] with some default padding
class SizedLoading extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CircularProgressIndicator(),
      padding: EdgeInsets.only(
        right: UiHelper.card_margin,
        top: UiHelper.standard_padding,
      ),
    );
  }
}