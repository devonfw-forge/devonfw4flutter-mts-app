import 'package:copyable/copyable.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:quiver/core.dart';

@immutable
class Dish extends Equatable implements Copyable<Dish> {
  final String name;
  final String description;
  final double price;
  final String encodedImage;
  final String comment;
  final Map<String, bool> extras;

  Dish({
    @required this.name,
    @required this.description,
    @required this.price,
    @required this.encodedImage,
    @required this.extras,
    this.comment,
  });

  @override
  List<Object> get props => [name, selectedExtras()];

  int get hashCode => hash2(name.hashCode, selectedExtras().hashCode);

  String selectedExtras() {
    String res = "";
    extras.forEach((extra, picked) => res += picked ? extra + ", " : "");
    return res;
  }

  // Copyable Implementation
  @override
  Dish copy() => _copy(this);

  @override
  Dish copyWithMaster(Dish master) => _copy(master);

  @override
  Dish copyWith({
    String name,
    String description,
    double price,
    String encodedImage,
    String comment,
    Map<String, bool> extras,
  }) =>
      _copy(
        this,
        name: name,
        description: description,
        price: price,
        encodedImage: encodedImage,
        extras: extras,
        comment: comment,
      );

  static Dish _copy(
    Dish master, {
    String name,
    String description,
    double price,
    String encodedImage,
    String comment,
    Map<String, bool> extras,
  }) {
    return Dish(
      name: name ?? master?.name,
      description: description ?? master?.description,
      price: price ?? master?.price,
      encodedImage: encodedImage ?? master?.encodedImage,
      extras: extras ?? master?.extras,
      comment: comment ?? master?.comment,
    );
  }
}
