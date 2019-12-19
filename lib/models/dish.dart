import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/models/extra.dart';

@immutable
class Dish extends Equatable {
  final String name;
  final String description;
  final double price;
  final String encodedImage;
  final String assetImage;
  final int id;
  final Map<Extra, bool> extras;

  Dish({
    @required this.name,
    @required this.description,
    @required this.price,
    @required this.extras,
    @required this.id,
    this.encodedImage,
    this.assetImage,
  });

  @override
  List<Object> get props => [name, extras];

  @override
  toString() {
    String res = "\"$name\"";
    res += hasExtras() ? " with " + selectedExtras() : "";
    return res;
  } 

  bool hasExtras() => extras.values.contains(true);

  String selectedExtras() {
    if (!hasExtras()) return null;

    String res = "";
    extras.forEach((extra, picked) => res += picked ? extra.name + ", " : "");
    return res.replaceRange(res.length - 2, res.length - 1, "");
  }

  Dish copyWith({
    String name,
    String description,
    double price,
    String encodedImage,
    String assetImage,
    int id,
    Map<Extra, bool> extras,
  }) =>
      Dish(
        name: name ?? this.name,
        description: description ?? this.description,
        price: price ?? this.price,
        encodedImage: encodedImage ?? this.encodedImage,
        extras: extras ?? this.extras,
        assetImage: assetImage ?? this.assetImage,
        id: id ?? this.id,
      );
}
