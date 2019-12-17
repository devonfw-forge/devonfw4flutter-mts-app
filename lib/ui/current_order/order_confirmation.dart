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
import 'package:my_thai_star_flutter/blocs/localization_bloc.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/response_dialoge.dart';
import 'package:my_thai_star_flutter/ui/ui_helper.dart';

import 'package:my_thai_star_flutter/ui/current_order/alert_card.dart';

class OrderConfirmation extends StatefulWidget {
  const OrderConfirmation({Key key}) : super(key: key);

  @override
  _OrderConfirmationState createState() => _OrderConfirmationState();
}

class _OrderConfirmationState extends State<OrderConfirmation> {
  OrderBloc _orderBloc;
  FormValidationBloc _formValidationBloc;
  CheckboxFieldBloc _termsBloc = CheckboxFieldBloc();
  NonEmptyFieldBloc _bookingTokeBloc = NonEmptyFieldBloc();
  TextEditingController _bookingTokenController = TextEditingController();

  @override
  void initState() {
    _orderBloc = OrderBloc(BlocProvider.of<CurrentOrderBloc>(context));
    _formValidationBloc = FormValidationBloc([_termsBloc, _bookingTokeBloc]);

    BookingState currentBookingState =
        BlocProvider.of<BookingBloc>(context).currentState;

    if (currentBookingState is ConfirmedBookingState) {
      _bookingTokenController.text = currentBookingState.token;
      _bookingTokeBloc.dispatch(currentBookingState.token);
    }

    _setUpOrderResponses();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderBloc>(
      builder: (BuildContext context) => _orderBloc,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BlocBuilder<NonEmptyFieldBloc, ValidationState>(
            bloc: _bookingTokeBloc,
            builder: (context, ValidationState state) =>
                state is ValidState ? SizedBox() : AlertCard(),
          ),
          _BookingTokenField(
            bookingTokenBloc: _bookingTokeBloc,
            bookingTokenController: _bookingTokenController,
          ),
          _Terms(termsBloc: _termsBloc),
          _Buttons(
            formValidationBloc: _formValidationBloc,
            bookingTokenController: _bookingTokenController,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _orderBloc.dispose();
    _termsBloc.dispose();
    _formValidationBloc.dispose();
    _bookingTokeBloc.dispose();

    super.dispose();
  }

  void _setUpOrderResponses() {
    _orderBloc.state.listen((OrderState state) {
      if (state is ConfirmedOrderState) {
        BlocProvider.of<CurrentOrderBloc>(context).dispatch(ClearOrderEvent());

        showDialog(
          context: context,
          builder: (BuildContext context) => ResponseDialoge(
            headline: "Order Confirmed!",
            body: "Your delicious dishes will be waiting " +
                "for you when you arrive to your Booking.\n" +
                "Your order has the following ID:",
            copyableText: state.orderId.toString(),
          ),
        );
      } else if (state is RejectedOrderState) {
        showDialog(
          context: context,
          builder: (BuildContext context) => ResponseDialoge(
            headline: "Order Denied",
            body: "Your order could not be processed " +
                "for for the following reason:\n\n" +
                state.reason,
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
    @required TextEditingController bookingTokenController,
  })  : _formValidationBloc = formValidationBloc,
        _bookingTokenController = bookingTokenController,
        super(key: key);

  final FormValidationBloc _formValidationBloc;
  final TextEditingController _bookingTokenController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FlatButton(
          child: Text(
            LocalizationBloc.of(context).get("buttons/cancel"),
            style:
                Theme.of(context).textTheme.button.copyWith(color: Colors.grey),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        SizedBox(width: UiHelper.standard_padding),
        BlocBuilder<OrderBloc, OrderState>(
          builder: (context, OrderState state) {
            if (state is LoadingOrderState) {
              return _Loading();
            } else {
              return _Button(
                bookingTokenController: _bookingTokenController,
                formValidationBloc: _formValidationBloc,
              );
            }
          },
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
            title: Text(LocalizationBloc.of(context).get("formFields/terms")),
            value: state is ValidState,
            onChanged: (bool val) => _termsBloc.dispatch(val),
          ),
        ],
      ),
    );
  }
}

class _BookingTokenField extends StatelessWidget {
  const _BookingTokenField({
    Key key,
    @required NonEmptyFieldBloc bookingTokenBloc,
    @required TextEditingController bookingTokenController,
  })  : _bookingTokenBloc = bookingTokenBloc,
        _bookingTokenController = bookingTokenController,
        super(key: key);

  final NonEmptyFieldBloc _bookingTokenBloc;
  final TextEditingController _bookingTokenController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: UiHelper.standard_padding,
        left: UiHelper.standard_padding,
      ),
      child: BlocFormField(
        label: LocalizationBloc.of(context).get("formFields/referenceNumber"),
        errorHint:
            LocalizationBloc.of(context).get("formFields/referenceNumber"),
        formFieldBloc: _bookingTokenBloc,
        controller: _bookingTokenController,
      ),
    );
  }
}

class _Button extends StatelessWidget {
  final FormValidationBloc _formValidationBloc;
  final TextEditingController _bookingTokenController;

  const _Button({Key key, bookingTokenController, formValidationBloc})
      : _bookingTokenController = bookingTokenController,
        _formValidationBloc = formValidationBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormValidationBloc, ValidationState>(
      bloc: _formValidationBloc,
      builder: (context, ValidationState state) => RaisedButton(
        color: Theme.of(context).accentColor,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.grey,
        child: Text(
          LocalizationBloc.of(context).get("buttons/send"),
          style: Theme.of(context).textTheme.button,
        ),
        onPressed: state is ValidState
            ? () => BlocProvider.of<OrderBloc>(context)
                .dispatch(_bookingTokenController.text)
            : null,
      ),
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CircularProgressIndicator(),
      padding: EdgeInsets.only(
        right: UiHelper.card_margin,
        top: UiHelper.standard_padding,
      ),
    );
  }
}
