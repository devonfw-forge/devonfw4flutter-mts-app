import 'package:my_thai_star_flutter/data/dummy_data.dart';
import 'package:my_thai_star_flutter/models/booking.dart';
import 'package:my_thai_star_flutter/repositories/exchange_point.dart';

class BookingService extends ExchangePoint<Booking, String> {
  
  @override
  Future<String> post(Booking input) async {
    return DummyData.bookingNumber;
  }
}
