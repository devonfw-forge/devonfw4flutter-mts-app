import 'package:my_thai_star_flutter/models/booking.dart';
import 'package:my_thai_star_flutter/repositories/exchange_point.dart';

///Defines a mock [BookingService], that's meant for testing
class MockBookingService extends Service<Booking, String> {
  static const String _dummyToken = 'CB_DATE_ThisIsAMockToken';

  ///Will always return a fake booking token, no matter the input
  @override
  Future<String> post(Booking input) async => _dummyToken;
}
