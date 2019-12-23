import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/blocs/current_order_bloc.dart';
import 'package:my_thai_star_flutter/blocs/order_state.dart';
import 'package:my_thai_star_flutter/models/order.dart';
import 'package:my_thai_star_flutter/repositories/exchange_point.dart';

///Handles the placing of new [Order]s
///
///When receiving a booking token as [String], the [OrderBloc] uses the
///current state of the [CurrentOrderBloc] to place a new [Order] with 
///it's [Service]. The [OrderBloc] then emits new [OrderState] reflecting
///the result of that communication.
///
///#### Why inject the CurrentOrderBloc?
///I did this so that the UI does not need access to 2 blocs every time
///it needs to place a new [Order].
class OrderBloc extends Bloc<String, OrderState> {
  final Service _orderService;
  final CurrentOrderBloc _currentOrderBloc;

  ///Creates one [OrderBloc]
  ///
  ///The dependency on the the [_orderService] &
  ///[CurrentOrderBloc] are injected.
  OrderBloc({@required currentOrderBloc, @required orderService})
      : _orderService = orderService,
        _currentOrderBloc = currentOrderBloc;

  @override
  OrderState get initialState => InitialOrderState();

  @override
  Stream<OrderState> mapEventToState(String event) async* {
    if (event == null || event == '') {
      yield RejectedOrderState('Please enter a booking ID');
    } else {
      yield LoadingOrderState();

      try {
        int orderId = await _orderService.post(Order(
          bookingToken: event,
          positions: _currentOrderBloc.currentState.positions,
        ));

        if (orderId == 0 || orderId == null) {
          yield RejectedOrderState('Your booking was Denied');
        } else {
          yield ConfirmedOrderState(orderId);
        }
      } catch (e) {
        yield RejectedOrderState('Error connecting to the service');
      }
    }
  }
}
