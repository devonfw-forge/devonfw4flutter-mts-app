import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/models/extra.dart';

///Defines a dish offered by the fictional MyThaiStar restaurant
///
///#### Why Equatable?
///Extends [Equatable] to overwrite it's comparison behavior. 
///It will be compared based on it's [props] instead of it's reference.
///This way we can easily compare if 2 [Dish]es are the same, based on
///their values and not based on their location in memory.
///
///#### Why Immutable?
///All model classes are [immutable] because all models are or are part of 
///event and state classes. event and state classes are required to be [immutable]
///by the bloc package for the following reasons (1):
/// - It allows the library to detect state changes efficiently
/// - It makes handling data safer (no side-effects or mutations)
/// - It makes state management predictable because we're using static 
///   snapshots of our state instead of state which can change at any 
///   point in time leading to strange/unpredictable behavior.
///
///In general, we should always strive to designing software so that as many
///structures as feasible are immutable (2).
///
///(1) Felix Angelov, 2019 https://github.com/felangel/bloc/issues/292
///(2) J. Bloch, Effective Java, Second Edition. Upper Saddle River, NJ:
///Addison-Wesley, 2008
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
    String res = '\'$name\'';
    res += hasExtras() ? ' with ' + selectedExtras() : '';
    return res;
  } 

  bool hasExtras() => extras.values.contains(true);

  ///Provides formatted [String] containing the selected [Extra]s
  ///with comma separation
  String selectedExtras() {
    if (!hasExtras()) return null;

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
