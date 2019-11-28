import 'package:copyable/copyable.dart';

class Search implements Copyable<Search> {
  static const List<String> sortCriteria = ['Name', 'Price', 'Likes'];

  String query;
  String sortBy;
  bool descending;

  Search({
    this.query,
    this.sortBy = "Name",
    this.descending,
  });

  // Copyable Implementation
  @override
  Search copy() => _copy(this);

  @override
  Search copyWithMaster(Search master) => _copy(master);

  @override
  Search copyWith({
    String query,
    String sortBy,
    bool descending,
  }) =>
      _copy(
        this,
        query: query,
        sortBy: sortBy,
        descending: descending,
      );

  static Search _copy(
    Search master, {
    String query,
    String sortBy,
    bool descending,
  }) {
    return Search(
      query: query ?? master?.query,
      sortBy: sortBy ?? master?.sortBy,
      descending: descending ?? master?.descending,
    );
  }
}
