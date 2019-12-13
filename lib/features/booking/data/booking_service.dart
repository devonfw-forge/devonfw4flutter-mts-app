import 'dart:convert';

import 'package:my_thai_star_flutter/features/booking/models/booking_error.dart';
import 'package:my_thai_star_flutter/features/booking/models/booking_request.dart';
import 'package:my_thai_star_flutter/features/booking/models/booking.dart';
import 'package:my_thai_star_flutter/repositories/exchange_point.dart';
import 'package:my_thai_star_flutter/features/booking/models/booking_response.dart';
import 'package:http/http.dart' as http;

class ServerException implements Exception {
  final String message;
  ServerException(this.message);
  String toString() => message;
}

class BookingService extends ExchangePoint<Booking, String> {
  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };
  static const String endPoint =
      'http://10.0.2.2:8082/mythaistar/services/rest/bookingmanagement/v1/booking';

  static String dummyBookingNumber = "CB_DATE_ThisIsAMockToken";

  @override
  Future<String> post(Booking input) async {
    BookingRequest requestBody = BookingRequest.fromBooking(input);
    http.Response response;

    try {
      response = await http.post(
        endPoint,
        headers: requestHeaders,
        body: jsonEncode(requestBody.toJson()),
      );
    } catch (e) {
      return dummyBookingNumber;
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
