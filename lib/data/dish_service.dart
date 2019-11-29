import 'dart:convert';

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

  final List<Dish> dummyDishes = [
    Dish(
      name: "THAI GREEN CHICKEN CURRY",
      description: "Master this aromatic, creamy & extremely tasty" +
          " chicken Thai green curry recipe from Jamie Oliver & treat" +
          " yourself to an authentic taste of South East Asia.",
      price: 14.75,
      assetImage: "assets/images/green-curry.jpg",
      extras: {
        "Tofu": false,
        "Extra Curry": false,
      },
      comment: "",
    ),
    Dish(
      name: "THAI SPICY BASIL FRIED RICE",
      description: "This is a staple of Thai cooking. " +
          "Adjust the spices to your own tastes for a really " +
          "great use for leftover rice!! I get the basil from a " +
          "local Asian market. It has a different flavor than " +
          "that of regular basil and makes all the difference " +
          "in this recipe. It is fast and fairly easy to make, " +
          "but requires constant stirring",
      price: 12.99,
      assetImage: "assets/images/basil-fried.jpg",
      extras: {
        "Tofu": false,
        "Extra Curry": false,
      },
      comment: "",
    ),
  ];

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
      return dummyDishes;
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
