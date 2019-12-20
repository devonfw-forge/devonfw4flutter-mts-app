import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

///Defines a search query that describes a list [Dish]es and how they should
///be sorted.
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
