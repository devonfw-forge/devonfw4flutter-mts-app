import 'package:my_thai_star_flutter/models/order.dart';
import 'package:my_thai_star_flutter/repositories/exchange_point.dart';

class OrderService extends ExchangePoint<Order, bool> {
  static const String endPoint = 'bookingmanagement/v1/booking';

  @override
  Future<bool> post(Order input) async {
    return false;
  }
  
}
