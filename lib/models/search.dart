import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

///Defines a search query that describes a list [Dish]es and how they should
///be sorted.
///
///#### Why Equatable?
///Extends [Equatable] to overwrite it's comparison behavior. 
///It will be compared based on it's [props] instead of it's reference.
///This way we can easily compare if 2 [Order]s are the same, based on
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
///Addison-Wesley, 2008.
@immutable
class Search extends Equatable {
  static const List<String> sortCriteria = ['name', 'price', 'likes'];

  ///defines which names and descriptions are a 
  ///match for this [Search]
  final String query;
  final String sortBy;
  final bool descending;

  Search({
    this.query = '',
    this.sortBy = 'name',
    this.descending = true,
  });

  Search copyWith({
    String query,
    String sortBy,
    bool descending,
  }) =>
      Search(
        query: query ?? this.query,
        sortBy: sortBy ?? this.sortBy,
        descending: descending ?? this.descending,
      );

  @override
  List<Object> get props => [query, sortBy, descending];
}
