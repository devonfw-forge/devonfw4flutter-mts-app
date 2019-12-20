import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

///Defines an addition to a Dish offered by the fictional MyThaiStar restaurant
///
///Examples: 'Extra Curry', 'Tofu'
///More info: https://github.com/Fasust/my-thai-star-flutter/blob/master/lib/models/README.md
@immutable
class Extra extends Equatable {
  final int id;
  final String name;

  Extra({@required this.name, @required this.id});

  @override
  List<Object> get props => [name, id];
}
