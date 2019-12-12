import 'package:equatable/equatable.dart';

abstract class OrderState implements Equatable {}

class InitialOrderState extends OrderState {
  @override
  List<Object> get props => ["initial"];
}

class RejectedOrderState extends OrderState {
  final String reason;

  RejectedOrderState(this.reason);

  @override
  List<Object> get props => [reason];
}

class ConfirmedOrderState extends OrderState {
  final int bookingId;

  ConfirmedOrderState(this.bookingId);
  
  @override
  List<Object> get props => [bookingId];
}
