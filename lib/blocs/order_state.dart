import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class OrderState implements Equatable {}

@immutable
class InitialOrderState extends OrderState {
  @override
  List<Object> get props => ["initial"];
}

@immutable
class RejectedOrderState extends OrderState {
  final String reason;

  RejectedOrderState(this.reason);

  @override
  List<Object> get props => [reason];
}

@immutable
class ConfirmedOrderState extends OrderState {
  final int orderId;

  ConfirmedOrderState(this.orderId);
  
  @override
  List<Object> get props => [orderId];
}
