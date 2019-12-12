import 'dart:convert';

import 'package:my_thai_star_flutter/features/current_order/models/order.dart';
import 'package:my_thai_star_flutter/features/current_order/models/order_request.dart';
import 'package:my_thai_star_flutter/features/current_order/models/order_response.dart';
import 'package:my_thai_star_flutter/repositories/exchange_point.dart';
import 'package:http/http.dart' as http;

class OrderService extends ExchangePoint<Order, bool> {
    Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };
  static const String endPoint =
      'http://10.0.2.2:8082/mythaistar/services/rest/ordermanagement/v1/order';
 
  @override
  Future<bool> post(Order input) async {
    OrderRequest requestBody = OrderRequest.fromOrder(input);
    http.Response response;

    try {
      response = await http.post(
        endPoint,
        headers: requestHeaders,
        body: jsonEncode(requestBody.toJson()),
      );
    } catch (e) {
      return false;
    }

    //TODO Confirmation Validation

    Map<dynamic, dynamic> respJson = json.decode(response.body);
    OrderResponse bookingResponse = OrderResponse.fromJson(respJson);

    return true;
  }

}
