import 'dart:convert';

import 'package:my_thai_star_flutter/models/dish.dart';
import 'package:my_thai_star_flutter/models/generated/search_request.dart';
import 'package:my_thai_star_flutter/models/generated/search_response.dart';
import 'package:my_thai_star_flutter/models/search.dart';
import 'package:my_thai_star_flutter/repositories/exchange_point.dart';
import 'package:http/http.dart' as http;

class DishService extends Service<Search, List<Dish>> {
  static const int _timeOut = 4;
  static const String _endPoint = 'http://10.0.2.2:8082/mythaistar/services/' +
      'rest/dishmanagement/v1/dish/search';

  static const Map<String, String> _requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  @override
  Future<List<Dish>> post(Search input) async {
    SearchRequest requestBody = SearchRequest.fromSearch(input);
    http.Response response;

    response = await http
        .post(
          _endPoint,
          headers: _requestHeaders,
          body: jsonEncode(requestBody.toJson()),
        )
        .timeout(const Duration(seconds: _timeOut));

    if (response.body == '') throw NoSuchEntriesException();

    Map<dynamic, dynamic> respJson = json.decode(response.body);
    SearchResponse searchResponse = SearchResponse.fromJson(respJson);
    List<Dish> dishes = List();
    searchResponse.content.forEach((content) {
      dishes.add(content.toDish());
    });

    return dishes;
  }
}

class NoSuchEntriesException implements Exception {
  @override
  String toString() => 'We did not find any dishes matching your search.';
}
