import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:quiver/core.dart';

@immutable
class Dish extends Equatable {
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

  Dish.cloneWithExtras(Dish dish, Map<String, bool> newExtras)
      : this(
          name: dish.name,
          description: dish.description,
          price: dish.price,
          imageLocation: dish.imageLocation,
          extras: newExtras,
          comment: dish.comment,
        );

  String selectedExtras() {
    String res = "";
    extras.forEach((extra, picked) => res += picked ? extra + ", " : "");
    return res;
  }
}
