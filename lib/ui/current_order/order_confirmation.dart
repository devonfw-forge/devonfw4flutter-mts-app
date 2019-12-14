import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_bloc/barrel.dart';
import 'package:my_thai_star_flutter/ui/booking/bloc_form_field.dart';
import 'package:my_thai_star_flutter/blocs/booking_bloc.dart';
import 'package:my_thai_star_flutter/blocs/booking_state.dart';
import 'package:my_thai_star_flutter/blocs/current_order_bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_order_event.dart';
import 'package:my_thai_star_flutter/blocs/order_bloc.dart';
import 'package:my_thai_star_flutter/blocs/order_state.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/labeled_checkbox.dart';
import 'package:my_thai_star_flutter/ui/ui_helper.dart';

import 'package:my_thai_star_flutter/ui/current_order/alert_card.dart';

class OrderConfirmation extends StatefulWidget {
  const OrderConfirmation({Key key}) : super(key: key);

  @override
  _OrderConfirmationState createState() => _OrderConfirmationState();
}

class _OrderConfirmationState extends State<OrderConfirmation> {
  OrderBloc orderBloc;
  FormValidationBloc _formValidationBloc;
  CheckboxFieldBloc _termsBloc = CheckboxFieldBloc();
  NonEmptyFieldBloc _bookingIdBloc = NonEmptyFieldBloc();
  TextEditingController _bookingIdController = TextEditingController();

  @override
  void initState() {
    _formValidationBloc = FormValidationBloc([
      _termsBloc,
      _bookingIdBloc,
    ]);

    BookingState bookingState =
        BlocProvider.of<BookingBloc>(context).currentState;

    if (bookingState is ConfirmedBookingState) {
      _bookingIdController.text = bookingState.bookingId;
      _bookingIdBloc.dispatch(bookingState.bookingId);
    }

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
        BlocBuilder<NonEmptyFieldBloc, ValidationState>(
          bloc: _bookingIdBloc,
          builder: (context, ValidationState state) =>
              state is ValidState ? SizedBox() : AlertCard(),
        ),
        Padding(
          padding: EdgeInsets.only(
            right: UiHelper.standart_padding,
            left: UiHelper.standart_padding,
          ),
          child: BlocFormField(
            label: "Booking ID",
            errorHint: "Please enter a Booking ID",
            formFieldBloc: _bookingIdBloc,
            controller: _bookingIdController,
          ),
        ),
        BlocBuilder<CheckboxFieldBloc, ValidationState>(
          bloc: _termsBloc,
          builder: (context, ValidationState state) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              LabeledCheckBox(
                label: "Accept Terms",
                state: state is ValidState,
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
                onPressed: state is ValidState
                    ? () => orderBloc.dispatch(_bookingIdController.text)
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
