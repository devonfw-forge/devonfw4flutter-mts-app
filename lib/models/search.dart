class Search{
  static const List<String> sortCriteria = ['Name', 'Price', 'Description'];

  String query;
  String sortBy;
  bool descending;

  Search({
    this.query,
    this.sortBy = 'Name',
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
}
