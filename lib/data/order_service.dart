import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/models/order.dart';
import 'package:my_thai_star_flutter/models/generated/order_request.dart';
import 'package:my_thai_star_flutter/models/generated/order_response.dart';
import 'package:my_thai_star_flutter/repositories/service.dart';
import 'package:http/http.dart' as http;

///Handles communication with the My Thai Star order Api
///
///An [Order], in the My Thai Star context, is a set of [Dish]es that are
///ordered for a [Booking] made at the fictional My Thai Star restaurant.
///An [Order] is linked to a [Booking] through a booking token which will be
///obtained after placing a [Booking].
class OrderService extends Service<Order, int> {
  static const int _timeOut = 4;
  static const String _route = 'mythaistar/services/rest/ordermanagement/v1/order';
  final String _baseUrl;

  static const Map<String, String> _requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  OrderService({@required String baseUrl}) : _baseUrl = baseUrl;

  ///Posts one [Order] to the Api and returns the related order id
  ///
  ///Will throw [Exception]s if the communication with the APi fails.
  ///The order id has no other purpose then uniquely identifying 
  ///a placed [Order].
  @override
  Future<int> post(Order input) async {
    OrderRequest requestBody = OrderRequest.fromOrder(input);
    http.Response response = await http
        .post(
          _baseUrl + _route,
          headers: _requestHeaders,
          body: jsonEncode(requestBody.toJson()),
        )
        .timeout(const Duration(seconds: _timeOut));

    Map<dynamic, dynamic> respJson = json.decode(response.body);
    OrderResponse orderResponse = OrderResponse.fromJson(respJson);

    if(orderResponse.orderId == null) throw Exception("Server did not place the Order");

    return orderResponse.orderId;
  }
}
