import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/models/dish.dart';
import 'package:my_thai_star_flutter/models/generated/search_request.dart';
import 'package:my_thai_star_flutter/models/generated/search_response.dart';
import 'package:my_thai_star_flutter/models/search.dart';
import 'package:my_thai_star_flutter/repositories/service.dart';
import 'package:http/http.dart' as http;

///Handles communication with the My Thai Star dish Api
///
///The dish Api is responsible for providing a set of [Dish]es
///that match a given [Search]
class DishService extends Service<Search, List<Dish>> {
  static const int _timeOut = 4;
  static const String _route =
      'mythaistar/services/rest/dishmanagement/v1/dish/search';
  final String _baseUrl;

  static const Map<String, String> _requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  DishService({@required String baseUrl}) : _baseUrl = baseUrl;

  ///Posts one [Search] to the Api and returns [Dish]es matching that [Search]
  ///
  ///Will throw [Exception]s if the communication with the APi fails or
  ///if no matching [Dish]es where found.
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

    if (response.body == '') throw Exception("No dishes match that query");

    Map<dynamic, dynamic> respJson = json.decode(response.body);
    SearchResponse searchResponse = SearchResponse.fromJson(respJson);

    if (searchResponse.content == null) throw Exception("Received invalid response from Server");

    return searchResponse.toDishList();
  }
}
