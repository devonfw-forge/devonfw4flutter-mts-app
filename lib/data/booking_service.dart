import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/models/generated/booking_error.dart';
import 'package:my_thai_star_flutter/models/generated/booking_request.dart';
import 'package:my_thai_star_flutter/models/booking.dart';
import 'package:my_thai_star_flutter/repositories/exchange_point.dart';
import 'package:my_thai_star_flutter/models/generated/booking_response.dart';
import 'package:http/http.dart' as http;

class BookingService extends Service<Booking, String> {
  static const int _timeOut = 4;
  static const String _route = 'mythaistar/services/rest/bookingmanagement/v1/booking';
   final String _baseUrl;

  static const Map<String, String> _requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  BookingService({@required String baseUrl}) : _baseUrl = baseUrl;

  @override
  Future<String> post(Booking input) async {
    BookingRequest requestBody = BookingRequest.fromBooking(input);

    http.Response response = await http
        .post(
          _baseUrl + _route,
          headers: _requestHeaders,
          body: jsonEncode(requestBody.toJson()),
        )
        .timeout(const Duration(seconds: _timeOut));

    Map<dynamic, dynamic> respJson = json.decode(response.body);

    //Check if response contained an error
    BookingError bookingError = BookingError.fromJson(respJson);
    if (bookingError.message != null) {
      throw ServerException(bookingError.message);
    } else {
      //If it doesn't, return the bookingToken
      BookingResponse bookingResponse = BookingResponse.fromJson(respJson);
      return bookingResponse.bookingToken;
    }
  }
}

class ServerException implements Exception {
  final String _message;
  ServerException(message) : _message = message;

  @override
  String toString() => _message;
}
