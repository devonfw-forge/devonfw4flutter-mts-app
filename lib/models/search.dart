import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Search extends Equatable {
  static const List<String> sortCriteria = ['name', 'price', 'likes'];

  final String query;
  final String sortBy;
  final bool descending;

  Search({
    this.query,
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
