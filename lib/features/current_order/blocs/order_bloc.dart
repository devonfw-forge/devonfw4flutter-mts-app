import 'dart:async';
import 'dart:collection';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:my_thai_star_flutter/features/current_order/blocs/current_order_bloc.dart';
import 'package:my_thai_star_flutter/features/current_order/data/order_service.dart';
import 'package:my_thai_star_flutter/features/current_order/models/order.dart';
import 'package:my_thai_star_flutter/repositories/exchange_point.dart';

enum OrderState { confirmed, rejected }

class OrderBloc extends Bloc<String, OrderState> {
  final ExchangePoint orderService = OrderService();
  final CurrentOrderBloc currentOrderBloc;

  OrderBloc(this.currentOrderBloc);

  @override
  OrderState get initialState => OrderState.rejected;

  @override
  Stream<OrderState> mapEventToState(String event) async* {
    bool accepted;
    try{
      accepted = await orderService.post(Order(
      bookingCode: event,
      dishes: currentOrderBloc.currentState,
    ));
    }catch(e){
      accepted = false;
    }
     
    if (accepted)
      yield OrderState.confirmed;
    else
      yield OrderState.rejected;
  }
}
