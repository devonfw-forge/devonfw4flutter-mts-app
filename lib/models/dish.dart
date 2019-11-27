import 'package:flutter/cupertino.dart';

class Dish {
  final String name;
  final String description;
  final double price;
  final String imageLocation;
  String comment;
  List<String> extras;

  Dish({
    @required this.name,
    @required this.description,
    @required this.price,
    @required this.imageLocation,
    this.extras,
    this.comment,
  });
}
