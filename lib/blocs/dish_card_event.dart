import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/models/extra.dart';

///Gives the ability to modify the state of the [DishCardBloc]
@immutable
abstract class DishCardEvent extends Equatable {}

///Sets the bool of the given [Extra] in [Dish.extras] to [picked]
@immutable
class SetExtraEvent extends DishCardEvent {
  final Extra extra;
  final bool picked;

  SetExtraEvent({this.extra, this.picked});

  @override
  List<Object> get props => [extra, picked];

  @override
  String toString() => 'SetExtra/${extra.toString()} to ${picked.toString()}';
}
