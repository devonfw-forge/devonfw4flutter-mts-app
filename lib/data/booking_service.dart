import 'dart:convert';

import 'package:my_thai_star_flutter/models/generated/booking_error.dart';
import 'package:my_thai_star_flutter/models/generated/booking_request.dart';
import 'package:my_thai_star_flutter/models/booking.dart';
import 'package:my_thai_star_flutter/repositories/exchange_point.dart';
import 'package:my_thai_star_flutter/models/generated/booking_response.dart';
import 'package:http/http.dart' as http;

class BookingService extends ExchangePoint<Booking, String> {
  static const int _timeOut = 4;
  static const String _dummyBookingNumber = 'CB_DATE_ThisIsAMockToken';
  static const String _endPoint = 'http://10.0.2.2:8082/mythaistar/services/' +
      'rest/bookingmanagement/v1/booking';

  static const Map<String, String> _requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  @override
  Future<String> post(Booking input) async {
    BookingRequest requestBody = BookingRequest.fromBooking(input);
    http.Response response;

    try {
      response = await http
          .post(
            _endPoint,
            headers: _requestHeaders,
            body: jsonEncode(requestBody.toJson()),
          )
          .timeout(const Duration(seconds: _timeOut));
    } catch (e) {
      return _dummyBookingNumber;
    }

    Map<dynamic, dynamic> respJson = json.decode(response.body);

    BookingError bookingError = BookingError.fromJson(respJson);
    if (bookingError.message != null) {
      throw ServerException(bookingError.message);
    }

    BookingResponse bookingResponse = BookingResponse.fromJson(respJson);

    return bookingResponse.bookingToken;
  }
}

class ServerException implements Exception {
  final String _message;
  ServerException(message) : _message = message;

  @override
  String toString() => _message;
}