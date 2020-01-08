import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/models/generated/booking_error.dart';
import 'package:my_thai_star_flutter/models/generated/booking_request.dart';
import 'package:my_thai_star_flutter/models/booking.dart';
import 'package:my_thai_star_flutter/repositories/service.dart';
import 'package:my_thai_star_flutter/models/generated/booking_response.dart';
import 'package:http/http.dart' as http;

///Handles communication with the My Thai Star booking Api
///
///A [Booking], in the My Thai Star context, is a reservation made
///at the fictional My Thai Star restaurant. Once a [Booking] is placed,
///the returned booking token can be used to [Order] [Dish]es for that
///[Booking].
class BookingService extends Service<Booking, String> {
  static const int _timeOut = 4;
  static const String _route =
      'mythaistar/services/rest/bookingmanagement/v1/booking';
  final String _baseUrl;

  static const Map<String, String> _requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  BookingService({@required String baseUrl}) : _baseUrl = baseUrl;

  ///Posts one [Booking] to the Api and returns the related booking token
  ///
  ///Will throw [Exception]s if the communication with the APi fails or
  ///if the [Booking] could not be placed.
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
    if (bookingError.message != null) throw Exception(bookingError.message);

    BookingResponse bookingResponse = BookingResponse.fromJson(respJson);
    if (bookingResponse.bookingToken == null) throw Exception("Booking could not be placed");

    return bookingResponse.bookingToken;
  }
}
