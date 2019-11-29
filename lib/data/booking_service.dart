import 'package:my_thai_star_flutter/models/booking.dart';
import 'package:my_thai_star_flutter/repositories/exchange_point.dart';

class BookingService extends ExchangePoint<Booking, String> {
  static const String endPoint = 'bookingmanagement/v1/booking';

  @override
  Future<String> post(Booking input) async {
    return "CB_20191129_ffcc0c387c07db666026a1c218a8479a";
  }
}
