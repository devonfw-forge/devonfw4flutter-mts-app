import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/models/dish.dart';
import 'package:my_thai_star_flutter/models/generated/search_request.dart';
import 'package:my_thai_star_flutter/models/generated/search_response.dart';
import 'package:my_thai_star_flutter/models/search.dart';
import 'package:my_thai_star_flutter/repositories/exchange_point.dart';
import 'package:http/http.dart' as http;

class DishService extends Service<Search, List<Dish>> {
  static const int _timeOut = 4;
  static const String _route = 'mythaistar/services/rest/dishmanagement/v1/dish/search';
  final String _baseUrl;

  static const Map<String, String> _requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  DishService({@required String baseUrl}) : _baseUrl = baseUrl;

  @override
  Future<List<Dish>> post(Search input) async {
    SearchRequest requestBody = SearchRequest.fromSearch(input);
    http.Response response = await http
        .post(
          _baseUrl + _route,
          headers: _requestHeaders,
          body: jsonEncode(requestBody.toJson()),
        )
        .timeout(const Duration(seconds: _timeOut));

    if (response.body == '') throw NoSuchEntriesException();

    Map<dynamic, dynamic> respJson = json.decode(response.body);
    SearchResponse searchResponse = SearchResponse.fromJson(respJson);

    return searchResponse.toDishList();
  }
}

class NoSuchEntriesException implements Exception {
  @override
  String toString() => 'We did not find any dishes matching your search.';
}
