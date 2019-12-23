import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/data/booking_service.dart';
import 'package:my_thai_star_flutter/data/dish_service.dart';
import 'package:my_thai_star_flutter/data/order_service.dart';
import 'package:my_thai_star_flutter/data/mock/mock_booking_service.dart';
import 'package:my_thai_star_flutter/data/mock/mock_dish_service.dart';
import 'package:my_thai_star_flutter/data/mock/mock_order_service.dart';
import 'package:my_thai_star_flutter/repositories/exchange_point.dart';

///Generates and hold all repositories of the Application
///
///The [RepositoryBundle] will generate all relevant repositories once on
///creation and then hold them in it's member variables. Based on the [mock]
///boolean, the [RepositoryBundle] will either generate mock or real repositories.
///
///The [RepositoryBundle] exists to have all repository generation in once central location.
///It will be provided globally using a [RepositoryProvider] so it can easily be used
///to inject dependencies into th [Bloc]s of the application.
@immutable
class RepositoryBundle {
  final Service dish;
  final Service booking;
  final Service order;

  RepositoryBundle(bool mock)
      : dish = _buildDishRepository(mock),
        booking = _buildBookingRepository(mock),
        order = _buildOrderRepository(mock);

  static Service _buildDishRepository(bool mock) {
    if (mock) {
      return MockDishService();
    } else {
      return DishService();
    }
  }

  static Service _buildBookingRepository(bool mock) {
    if (mock) {
      return MockBookingService();
    } else {
      return BookingService();
    }
  }

  static Service _buildOrderRepository(bool mock) {
    if (mock) {
      return MockOrderService();
    } else {
      return OrderService();
    }
  }
}
