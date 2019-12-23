import 'dart:convert';

import 'package:my_thai_star_flutter/models/order.dart';
import 'package:my_thai_star_flutter/models/generated/order_request.dart';
import 'package:my_thai_star_flutter/models/generated/order_response.dart';
import 'package:my_thai_star_flutter/repositories/exchange_point.dart';
import 'package:http/http.dart' as http;

class OrderService extends Service<Order, int> {
  static const int _timeOut = 4;
  static const String _endPoint = 'http://10.0.2.2:8082/mythaistar/services/' +
      'rest/ordermanagement/v1/order';

  static const Map<String, String> _requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  @override
  Future<int> post(Order input) async {
    OrderRequest requestBody = OrderRequest.fromOrder(input);
    http.Response response = await http
        .post(
          _endPoint,
          headers: _requestHeaders,
          body: jsonEncode(requestBody.toJson()),
        )
        .timeout(const Duration(seconds: _timeOut));

    Map<dynamic, dynamic> respJson = json.decode(response.body);
    OrderResponse bookingResponse = OrderResponse.fromJson(respJson);

    return bookingResponse.bookingId;
  }
}
