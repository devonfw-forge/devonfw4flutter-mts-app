import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_bloc/barrel.dart';
import 'package:my_thai_star_flutter/ui/current_order/order_form_buttons.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/form/bloc_checkbox_tile.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/form/bloc_form_field.dart';
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

class OrderForm extends StatefulWidget {

  @override
  _OrderFormState createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
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
          BlocCheckboxTile(
            checkboxBloc: _termsBloc,
            label: LocalizationBloc.of(context).get("formFields/terms"),
          ),
          OrderFormButtons(
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
          builder: (BuildContext context) => ResponseDialog(
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
          builder: (BuildContext context) => ResponseDialog(
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

class _BookingTokenField extends StatelessWidget {
  final NonEmptyFieldBloc _bookingTokenBloc;
  final TextEditingController _bookingTokenController;

  const _BookingTokenField({
    Key key,
    @required NonEmptyFieldBloc bookingTokenBloc,
    @required TextEditingController bookingTokenController,
  })  : _bookingTokenBloc = bookingTokenBloc,
        _bookingTokenController = bookingTokenController,
        super(key: key);

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
