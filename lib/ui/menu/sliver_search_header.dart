import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/annotations.dart';
import 'package:my_thai_star_flutter/ui/menu/filter_buttons.dart';
import 'package:my_thai_star_flutter/ui/menu/search_bar.dart';
import 'package:my_thai_star_flutter/ui/menu/sort_dropdown.dart';
import 'package:my_thai_star_flutter/ui/ui_helper.dart';

///Defines the [SliverAppBar] at the top of the [MenuPage]
///
///[SliverSearchHeader] will disappear when scrolling down
///and reappear when scrolling up.
///The Category selection of the original Angular
///version was not implemented.
@NotFullyImplemented()
class SliverSearchHeader extends StatelessWidget {
  static const double _height = 160;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: UiHelper.elevation,
      floating: true,
      backgroundColor: Colors.white,
      leading: Container(),
      expandedHeight: _height,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              SearchBar(),
              SortDropdown(),
              FilterButtons(),
            ],
          ),
        ),
      ),
    );
  }
}