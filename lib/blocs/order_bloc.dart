import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_order_bloc.dart';
import 'package:my_thai_star_flutter/blocs/order_state.dart';
import 'package:my_thai_star_flutter/data/order_service.dart';
import 'package:my_thai_star_flutter/models/order.dart';
import 'package:my_thai_star_flutter/repositories/exchange_point.dart';

class OrderBloc extends Bloc<String, OrderState> {
  final ExchangePoint _orderService = OrderService();
  final CurrentOrderBloc _currentOrderBloc;

  OrderBloc(currentOrderBloc) : _currentOrderBloc = currentOrderBloc;

  @override
  OrderState get initialState => InitialOrderState();

  @override
  Stream<OrderState> mapEventToState(String event) async* {
    if (event == null || event == "") {
      yield RejectedOrderState("Please enter a booking ID");
    } else {
      yield LoadingOrderState();

      try {
        int orderId = await _orderService.post(Order(
          bookingCode: event,
          positions: _currentOrderBloc.currentState.positions,
        ));

        if (orderId == 0 || orderId == null) {
          yield RejectedOrderState("Your booking was Denied");
        } else {
          yield ConfirmedOrderState(orderId);
        }
      } catch (e) {
        yield RejectedOrderState("Error connecting to the service");
      }
    }
  }
}
