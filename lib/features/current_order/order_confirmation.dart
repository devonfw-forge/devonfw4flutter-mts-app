import 'dart:developer';

import 'package:bool_bloc/bool_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validation_bloc/barrel.dart';
import 'package:my_thai_star_flutter/features/booking/bloc_form_field.dart';
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
  FormValidationBloc _formValidationBloc;
  CheckboxValidationBloc _termsBloc;
  NameValidationBloc _bookingIdBloc;

  @override
  void initState() {
    //Validation
    _termsBloc = CheckboxValidationBloc();
    _bookingIdBloc = NameValidationBloc();
    _formValidationBloc = FormValidationBloc([
      _termsBloc,
      _bookingIdBloc,
    ]);

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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        BlocBuilder<NameValidationBloc, ValidationState>(
          bloc: _bookingIdBloc,
          builder: (context, ValidationState state) =>
              state == ValidationState.valid ? SizedBox() : AlertCard(),
        ),
        Padding(
          padding: const EdgeInsets.only(
            right: UiHelper.standart_padding,
            left: UiHelper.standart_padding,
          ),
          child: BlocFormField(
            label: "Booking ID",
            errorHint: "Please enter a Booking ID",
            validationBloc: _bookingIdBloc,
          ),
        ),
        BlocBuilder<CheckboxValidationBloc, ValidationState>(
          bloc: _termsBloc,
          builder: (context, ValidationState state) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              LabeledCheckBox(
                label: "Accept Terms",
                state: state == ValidationState.valid,
                onStateChange: (bool val) => _termsBloc.dispatch(val),
              ),
            ],
          ),
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
            BlocBuilder<FormValidationBloc, ValidationState>(
              bloc: _formValidationBloc,
              builder: (context, ValidationState state) => RaisedButton(
                color: Theme.of(context).accentColor,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.grey,
                child: Text(
                  "SEND ORDER",
                  style: Theme.of(context).textTheme.button,
                ),
                onPressed: state == ValidationState.valid
                    ? () => orderBloc.dispatch("")
                    : null,
              ),
            ),
            SizedBox(width: UiHelper.standart_padding),
          ],
        )
      ],
    );
  }

  @override
  void dispose() {
    orderBloc.dispose();
    _termsBloc.dispose();
    _formValidationBloc.dispose();
    _bookingIdBloc.dispose();

    super.dispose();
  }
}
