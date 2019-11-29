import 'dart:convert';

import 'package:my_thai_star_flutter/data/dummy_data.dart';
import 'package:my_thai_star_flutter/models/dish.dart';
import 'package:my_thai_star_flutter/models/generated/search_request.dart';
import 'package:my_thai_star_flutter/models/generated/search_response.dart';
import 'package:my_thai_star_flutter/models/search.dart';
import 'package:my_thai_star_flutter/repositories/exchange_point.dart';
import 'package:http/http.dart' as http;

class NoSuchEntriesException implements Exception {
  String toString() => "We did not find any dishes matching your search.";
}

class DishService extends ExchangePoint<Search, List<Dish>> {
  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };
  static const String endPoint =
      'http://10.0.2.2:8082/mythaistar/services/rest/dishmanagement/v1/dish/search';


  @override
  Future<List<Dish>> post(Search input) async {
    SearchRequest requestBody = SearchRequest.fromSearch(input);
    http.Response response;

    try {
      response = await http.post(
        endPoint,
        headers: requestHeaders,
        body: jsonEncode(requestBody.toJson()),
      );
    } catch (e) {
      return DummyData.dishes;
    }

    if (response.body == "") throw NoSuchEntriesException();

    Map<dynamic, dynamic> respJson = json.decode(response.body);
    SearchResponse searchResponse = SearchResponse.fromJson(respJson);
    List<Dish> dishes = List();
    searchResponse.content.forEach((content) {
      dishes.add(content.toDish());
    });

    return dishes;
  }
}
