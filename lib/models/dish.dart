import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/models/extra.dart';

@immutable
class Dish extends Equatable{
  final String name;
  final String description;
  final double price;
  final String encodedImage;
  final String assetImage;
  final String comment;
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
    this.comment,
  });

  @override
  List<Object> get props => [name, selectedExtras()];

  String selectedExtras() {
    String res = "";
    extras.forEach((extra, picked) => res += picked ? extra.name + ", " : "");
    return res;
  }

  Dish copyWith({
    String name,
    String description,
    double price,
    String encodedImage,
    String comment,
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
      comment: comment ?? this.comment,
      assetImage: assetImage ?? this.assetImage,
      id: id ?? this.id,
    );
}
