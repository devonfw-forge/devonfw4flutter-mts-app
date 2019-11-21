import 'package:my_thai_star_flutter/models/booking.dart';
import 'package:my_thai_star_flutter/models/booking_response.dart';
import 'package:my_thai_star_flutter/repositories/api.dart';

class BookingService extends Api<Booking, BookingResponse> {
  static const String endPoint = 'bookingmanagement/v1/booking';

  @override
  Future<BookingResponse> post(Booking input) {
    // TODO: implement get
    return null;
  }
}
