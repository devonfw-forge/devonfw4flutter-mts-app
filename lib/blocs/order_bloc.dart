import 'dart:async';
import 'dart:collection';
import 'package:bloc/bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_order_bloc.dart';
import 'package:my_thai_star_flutter/data/order_service.dart';
import 'package:my_thai_star_flutter/models/dish.dart';
import 'package:my_thai_star_flutter/models/order.dart';
import 'package:my_thai_star_flutter/repositories/exchange_point.dart';

enum OrderState { confirmed, rejected }

class OrderBloc extends Bloc<String, OrderState> {
  final ExchangePoint orderService = OrderService();
  final CurrentOrderBloc currentOrderBloc;
  LinkedHashMap<Dish, int> order;

  OrderBloc(this.currentOrderBloc);

  @override
  OrderState get initialState => OrderState.rejected;

  @override
  Stream<OrderState> mapEventToState(String event) async* {
    bool accepted = await orderService.post(Order(
      bookingCode: event,
      dishes: order,
    ));
    
    if (accepted)
      yield OrderState.confirmed;
    else
      yield OrderState.rejected;
  }
}
