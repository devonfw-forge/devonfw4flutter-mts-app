import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/models/booking.dart';
import 'package:my_thai_star_flutter/repositories/service.dart';

///Defines a mock [BookingService], that's meant for testing
@immutable
class MockBookingService extends Service<Booking, String> {
  static const String _dummyToken = 'CB_DATE_ThisIsAMockToken';

  ///Will always return a fake booking token, no matter the input
  @override
  Future<String> post(Booking input) async => _dummyToken;
}
