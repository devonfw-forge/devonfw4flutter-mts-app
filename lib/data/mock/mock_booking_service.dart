import 'package:my_thai_star_flutter/models/booking.dart';
import 'package:my_thai_star_flutter/repositories/exchange_point.dart';

class MockBookingService extends Service<Booking, String> {
  static const String _dummyToken = 'CB_DATE_ThisIsAMockToken';

  @override
  Future<String> post(Booking input) async {
    return _dummyToken;
  }
}
