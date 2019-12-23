import 'package:my_thai_star_flutter/models/order.dart';
import 'package:my_thai_star_flutter/repositories/exchange_point.dart';

class MockOrderService extends Service<Order, int> {
  static const int _dummyNumber = 1;

  @override
  Future<int> post(Order input) async {
    return _dummyNumber;
  }
}
