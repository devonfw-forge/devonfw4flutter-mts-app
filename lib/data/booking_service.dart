import 'package:my_thai_star_flutter/models/booking.dart';
import 'package:my_thai_star_flutter/models/booking_response.dart';
import 'package:my_thai_star_flutter/repositories/exchange_point.dart';

class BookingService extends ExchangePoint<Booking, BookingResponse> {
  static const String endPoint = 'bookingmanagement/v1/booking';

  @override
  Future<BookingResponse> post(Booking input) async {
    return BookingResponse();
  }
}
