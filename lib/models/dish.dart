import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/models/extra.dart';

///Defines a dish offered by the fictional MyThaiStar restaurant
///
///More info: https://github.com/devonfw-forge/devonfw4flutter-mts-app/blob/master/lib/models/README.md
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
  List<Object> get props => [name, id, extras, selectedExtras()];

  @override
  toString() {
    String res = '\'$name\'';
    res += hasSelectedExtras() ? ' with ' + selectedExtras() : '';
    return res;
  } 

  bool hasSelectedExtras() => extras.values.contains(true);

  ///Provides formatted [String] containing the selected [Extra]s
  ///with comma separation
  String selectedExtras() {
    if (!hasSelectedExtras()) return null;

    String res = '';
    extras.forEach((extra, picked) => res += picked ? extra.name + ', ' : '');
    return res.replaceRange(res.length - 2, res.length - 1, '');
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
