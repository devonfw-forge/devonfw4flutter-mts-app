import 'package:my_thai_star_flutter/models/search.dart';

///Generated with https://javiercbk.github.io/json_to_dart/
class SearchRequest {
  List<Categories> categories;
  String searchBy;
  Pageable pageable;
  int maxPrice;
  int minLikes;

  SearchRequest(
      {this.categories,
      this.searchBy,
      this.pageable,
      this.maxPrice,
      this.minLikes});

  SearchRequest.fromSearch(Search search) {
    categories = [];
    searchBy = search.query;
    pageable = Pageable(
      pageNumber: 0,
      pageSize: 8,
      sort: [
        Sort(
          property: search.sortBy.toLowerCase(),
          direction: search.descending ? "DESC" : "ASC",
        )
      ],
    );
  }

  SearchRequest.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = new List<Categories>();
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
    searchBy = json['searchBy'];
    pageable = json['pageable'] != null
        ? new Pageable.fromJson(json['pageable'])
        : null;
    maxPrice = json['maxPrice'];
    minLikes = json['minLikes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    data['searchBy'] = this.searchBy;
    if (this.pageable != null) {
      data['pageable'] = this.pageable.toJson();
    }
    data['maxPrice'] = this.maxPrice;
    data['minLikes'] = this.minLikes;
    return data;
  }
}

class Categories {
  String id;

  Categories({this.id});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}

class Pageable {
  int pageSize;
  int pageNumber;
  List<Sort> sort;

  Pageable({this.pageSize, this.pageNumber, this.sort});

  Pageable.fromJson(Map<String, dynamic> json) {
    pageSize = json['pageSize'];
    pageNumber = json['pageNumber'];
    if (json['sort'] != null) {
      sort = new List<Sort>();
      json['sort'].forEach((v) {
        sort.add(new Sort.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageSize'] = this.pageSize;
    data['pageNumber'] = this.pageNumber;
    if (this.sort != null) {
      data['sort'] = this.sort.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sort {
  String property;
  String direction;

  Sort({this.property, this.direction});

  Sort.fromJson(Map<String, dynamic> json) {
    property = json['property'];
    direction = json['direction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['property'] = this.property;
    data['direction'] = this.direction;
    return data;
  }
}
