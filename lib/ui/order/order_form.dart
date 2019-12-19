import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_bloc/barrel.dart';
import 'package:my_thai_star_flutter/ui/order/order_form_buttons.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/form/bloc_checkbox_tile.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/form/bloc_form_field.dart';
import 'package:my_thai_star_flutter/blocs/booking_bloc.dart';
import 'package:my_thai_star_flutter/blocs/booking_state.dart';
import 'package:my_thai_star_flutter/localization/translation.dart';
import 'package:my_thai_star_flutter/ui/ui_helper.dart';
import 'package:my_thai_star_flutter/ui/order/alert_card.dart';

///Defines the form part of the [OrderPage] & is responsible for
///
class OrderForm extends StatefulWidget {

  @override
  _OrderFormState createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  FormValidationBloc _formValidationBloc;
  CheckboxFieldBloc _termsBloc = CheckboxFieldBloc();
  NonEmptyFieldBloc _bookingTokeBloc = NonEmptyFieldBloc();
  TextEditingController _bookingTokenController = TextEditingController();

  @override
  void initState() {
    _formValidationBloc = FormValidationBloc([_termsBloc, _bookingTokeBloc]);

    BookingState currentBookingState =
        BlocProvider.of<BookingBloc>(context).currentState;

    if (currentBookingState is ConfirmedBookingState) {
      _bookingTokenController.text = currentBookingState.token;
      _bookingTokeBloc.dispatch(currentBookingState.token);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
          label: Translation.of(context).get("formFields/terms"),
        ),
        OrderFormButtons(
          formValidationBloc: _formValidationBloc,
          bookingTokenController: _bookingTokenController,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _termsBloc.dispose();
    _formValidationBloc.dispose();
    _bookingTokeBloc.dispose();

    super.dispose();
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
        label: Translation.of(context).get("formFields/referenceNumber"),
        errorHint:
            Translation.of(context).get("formFields/referenceNumber"),
        formFieldBloc: _bookingTokenBloc,
        controller: _bookingTokenController,
      ),
    );
  }
}
