import 'dart:developer';

import 'package:bool_bloc/bool_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_thai_star_flutter/features/current_order/blocs/current_order_bloc.dart';
import 'package:my_thai_star_flutter/features/current_order/blocs/current_order_event.dart';
import 'package:my_thai_star_flutter/features/current_order/blocs/order_bloc.dart';
import 'package:my_thai_star_flutter/features/current_order/blocs/order_state.dart';
import 'package:my_thai_star_flutter/shared_widgets/labeled_checkbox.dart';
import 'package:my_thai_star_flutter/ui_helper.dart';

import 'package:my_thai_star_flutter/features/current_order/alert_card.dart';

class OrderConfirmation extends StatefulWidget {
  const OrderConfirmation({Key key}) : super(key: key);

  @override
  _OrderConfirmationState createState() => _OrderConfirmationState();
}

class _OrderConfirmationState extends State<OrderConfirmation> {
  OrderBloc orderBloc;
  BoolBloc conditionsBloc = BoolBloc();
  TextEditingController _bookingIdController = TextEditingController();

  @override
  void initState() {
    orderBloc = OrderBloc(BlocProvider.of<CurrentOrderBloc>(context));

    orderBloc.state.listen(
      (OrderState state) {
        if (state is ConfirmedOrderState) {
          BlocProvider.of<CurrentOrderBloc>(context)
              .dispatch(ClearOrderEvent());

          Scaffold.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 3),
            content:
                Text("Order Confirmed with following ID:\n${state.bookingId}"),
          ));
        } else if (state is RejectedOrderState) {
          Scaffold.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 3),
            content: Text("Order Declined:\n${state.reason}"),
          ));
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _bookingIdController.text == "" ? AlertCard() : SizedBox(),
        Padding(
          padding: const EdgeInsets.only(
            right: UiHelper.standart_padding,
            left: UiHelper.standart_padding,
          ),
          child: TextField(
            controller: _bookingIdController,
            decoration: InputDecoration(
              labelText: "Booking ID",
            ),
          ),
        ),
        BlocBuilder(
          bloc: conditionsBloc,
          builder: (context, bool state) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              LabeledCheckBox(
                label: "Accept Terms",
                state: state,
                onStateChange: (_) =>
                    conditionsBloc.dispatch(BoolBlocEvent.swap),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                    child: Text(
                      "CANCEL",
                      style: Theme.of(context).textTheme.button.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  SizedBox(width: UiHelper.standart_padding),
                  RaisedButton(
                    color: Theme.of(context).accentColor,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.grey,
                    child: Text(
                      "SEND ORDER",
                      style: Theme.of(context).textTheme.button,
                    ),
                    onPressed: state
                        ? () => orderBloc.dispatch(_bookingIdController.text)
                        : null,
                  ),
                  SizedBox(width: UiHelper.standart_padding),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    orderBloc.dispose();
    _bookingIdController.dispose();

    super.dispose();
  }
}
