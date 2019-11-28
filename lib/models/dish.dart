import 'package:copyable/copyable.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:quiver/core.dart';

@immutable
class Dish extends Equatable implements Copyable<Dish> {
  final String name;
  final String description;
  final double price;
  final String imageLocation;
  final String comment;
  final Map<String, bool> extras;

  Dish({
    @required this.name,
    @required this.description,
    @required this.price,
    @required this.imageLocation,
    @required this.extras,
    @required this.comment,
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
    String imageLocation,
    String comment,
    Map<String, bool> extras,
  }) =>
      _copy(
        this,
        name: name,
        description: description,
        price: price,
        imageLocation: imageLocation,
        extras: extras,
        comment: comment,
      );

  static Dish _copy(
    Dish master, {
    String name,
    String description,
    double price,
    String imageLocation,
    String comment,
    Map<String, bool> extras,
  }) {
    return Dish(
      name: name ?? master?.name,
      description: description ?? master?.description,
      price: price ?? master?.price,
      imageLocation: imageLocation ?? master?.imageLocation,
      extras: extras ?? master?.extras,
      comment: comment ?? master?.comment,
    );
  }
}
