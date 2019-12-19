import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_search_bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_search_events.dart';
import 'package:my_thai_star_flutter/blocs/dish_bloc.dart';
import 'package:my_thai_star_flutter/ui/menu/filter_buttons.dart';
import 'package:my_thai_star_flutter/ui/menu/search_bar.dart';
import 'package:my_thai_star_flutter/localization/translation.dart';
import 'package:my_thai_star_flutter/ui/menu/sort_drop_down.dart';
import 'package:my_thai_star_flutter/ui/ui_helper.dart';

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
              SortDropDown(),
              FilterButtons(),
            ],
          ),
        ),
      ),
    );
  }
}