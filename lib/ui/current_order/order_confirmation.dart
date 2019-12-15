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
import 'package:my_thai_star_flutter/ui/shared_widgets/response_dialoge.dart';
import 'package:my_thai_star_flutter/ui/ui_helper.dart';

import 'package:my_thai_star_flutter/ui/current_order/alert_card.dart';

class OrderConfirmation extends StatefulWidget {
  const OrderConfirmation({Key key}) : super(key: key);

  @override
  _OrderConfirmationState createState() => _OrderConfirmationState();
}

class _OrderConfirmationState extends State<OrderConfirmation> {
  static const String confirmationHeadline = "Order Confirmed!";
  static const String confirmationBody =
      "Your delicious dishes will be waiting " +
          "for you when you arrive to your Booking.\n" +
          "Your order has teh following ID:";
  static const String deniedHeadline = "Order Denied";
  static const String deniedBody = "Your order could not be processed " +
      "for for the following reason:\n\n";

  OrderBloc _orderBloc;
  FormValidationBloc _formValidationBloc;
  CheckboxFieldBloc _termsBloc = CheckboxFieldBloc();
  NonEmptyFieldBloc _bookingIdBloc = NonEmptyFieldBloc();
  TextEditingController _bookingIdController = TextEditingController();

  @override
  void initState() {
    _orderBloc = OrderBloc(BlocProvider.of<CurrentOrderBloc>(context));
    _formValidationBloc = FormValidationBloc([_termsBloc, _bookingIdBloc]);

    BookingState currentBookingState =
        BlocProvider.of<BookingBloc>(context).currentState;

    if (currentBookingState is ConfirmedBookingState) {
      _bookingIdController.text = currentBookingState.bookingId;
      _bookingIdBloc.dispatch(currentBookingState.bookingId);
    }

    _setUpOrderResponses();

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
        _BookingId(
          bookingIdBloc: _bookingIdBloc,
          bookingIdController: _bookingIdController,
        ),
        _Terms(termsBloc: _termsBloc),
        _Buttons(
          formValidationBloc: _formValidationBloc,
          orderBloc: _orderBloc,
          bookingIdController: _bookingIdController,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _orderBloc.dispose();
    _termsBloc.dispose();
    _formValidationBloc.dispose();
    _bookingIdBloc.dispose();

    super.dispose();
  }

  void _setUpOrderResponses() {
    _orderBloc.state.listen((OrderState state) {
      if (state is ConfirmedOrderState) {
        BlocProvider.of<CurrentOrderBloc>(context).dispatch(ClearOrderEvent());

        showDialog(
          context: context,
          builder: (BuildContext context) => ResponseDialoge(
            headline: confirmationHeadline,
            body: confirmationBody,
            copyableText: state.bookingId.toString(),
          ),
        );
      } else if (state is RejectedOrderState) {
        showDialog(
          context: context,
          builder: (BuildContext context) => ResponseDialoge(
            headline: deniedHeadline,
            body: deniedBody + state.reason,
          ),
        );
      }
    });
  }
}

class _Buttons extends StatelessWidget {
  const _Buttons({
    Key key,
    @required FormValidationBloc formValidationBloc,
    @required OrderBloc orderBloc,
    @required TextEditingController bookingIdController,
  })  : _formValidationBloc = formValidationBloc,
        _orderBloc = orderBloc,
        _bookingIdController = bookingIdController,
        super(key: key);

  final FormValidationBloc _formValidationBloc;
  final OrderBloc _orderBloc;
  final TextEditingController _bookingIdController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FlatButton(
          child: Text(
            "CANCEL",
            style:
                Theme.of(context).textTheme.button.copyWith(color: Colors.grey),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        SizedBox(width: UiHelper.standard_padding),
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
                ? () => _orderBloc.dispatch(_bookingIdController.text)
                : null,
          ),
        ),
        SizedBox(width: UiHelper.standard_padding),
      ],
    );
  }
}

class _Terms extends StatelessWidget {
  const _Terms({
    Key key,
    @required CheckboxFieldBloc termsBloc,
  })  : _termsBloc = termsBloc,
        super(key: key);

  final CheckboxFieldBloc _termsBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckboxFieldBloc, ValidationState>(
      bloc: _termsBloc,
      builder: (context, ValidationState state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CheckboxListTile(
            title: Text("Accept Terms"),
            value: state is ValidState,
            onChanged: (bool val) => _termsBloc.dispatch(val),
          ),
        ],
      ),
    );
  }
}

class _BookingId extends StatelessWidget {
  const _BookingId({
    Key key,
    @required NonEmptyFieldBloc bookingIdBloc,
    @required TextEditingController bookingIdController,
  })  : _bookingIdBloc = bookingIdBloc,
        _bookingIdController = bookingIdController,
        super(key: key);

  final NonEmptyFieldBloc _bookingIdBloc;
  final TextEditingController _bookingIdController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: UiHelper.standard_padding,
        left: UiHelper.standard_padding,
      ),
      child: BlocFormField(
        label: "Booking ID",
        errorHint: "Please enter a Booking ID",
        formFieldBloc: _bookingIdBloc,
        controller: _bookingIdController,
      ),
    );
  }
}
