import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/data/booking_service.dart';
import 'package:my_thai_star_flutter/data/dish_service.dart';
import 'package:my_thai_star_flutter/data/order_service.dart';
import 'package:my_thai_star_flutter/repositories/exchange_point.dart';

@immutable
class RepositoryBundle {
  final Service dish;
  final Service booking;
  final Service order;

  RepositoryBundle()
      : dish = _buildDishRepository(),
        booking = _buildBookingRepository(),
        order = _buildOrderRepository();

  static Service _buildDishRepository() {
    return DishService();
  }

  static Service _buildBookingRepository() {
    return BookingService();
  }

  static Service _buildOrderRepository() {
    return OrderService();
  }
}
