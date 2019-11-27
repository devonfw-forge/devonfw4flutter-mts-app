import 'package:flutter/cupertino.dart';

class Dish {
  final String name;
  final String description;
  final double price;
  final String imageLocation;
  String comment;
  Map<String, bool> extras;

  Dish({
    @required this.name,
    @required this.description,
    @required this.price,
    @required this.imageLocation,
    this.extras,
    this.comment,
  });
}
