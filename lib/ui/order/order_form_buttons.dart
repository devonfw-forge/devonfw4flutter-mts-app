import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_bloc/barrel.dart';
import 'package:my_thai_star_flutter/blocs/current_order_bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_order_event.dart';
import 'package:my_thai_star_flutter/localization/translation.dart';
import 'package:my_thai_star_flutter/blocs/order_bloc.dart';
import 'package:my_thai_star_flutter/blocs/order_state.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/form/bloc_validation_button.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/response_dialoge.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/sized_loading.dart';
import 'package:my_thai_star_flutter/ui/ui_helper.dart';


class OrderFormButtons extends StatefulWidget {
  final FormValidationBloc _formValidationBloc;
  final TextEditingController _bookingTokenController;

  const OrderFormButtons({
    Key key,
    @required FormValidationBloc formValidationBloc,
    @required TextEditingController bookingTokenController,
  })  : _formValidationBloc = formValidationBloc,
        _bookingTokenController = bookingTokenController,
        super(key: key);

  @override
  _OrderFormButtonsState createState() => _OrderFormButtonsState(
        formValidationBloc: _formValidationBloc,
        bookingTokenController: _bookingTokenController,
      );
}

class _OrderFormButtonsState extends State<OrderFormButtons> {
  final FormValidationBloc _formValidationBloc;
  final TextEditingController _bookingTokenController;
  OrderBloc _orderBloc;

  _OrderFormButtonsState({
    @required formValidationBloc,
    @required bookingTokenController,
  })  : _formValidationBloc = formValidationBloc,
        _bookingTokenController = bookingTokenController;

  @override
  void initState() {
    _orderBloc = OrderBloc(BlocProvider.of<CurrentOrderBloc>(context));
    _setUpOrderResponses(_orderBloc);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FlatButton(
          child: Text(
            Translation.of(context).get("buttons/cancel"),
            style:
                Theme.of(context).textTheme.button.copyWith(color: Colors.grey),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        SizedBox(width: UiHelper.standard_padding),
        BlocBuilder<OrderBloc, OrderState>(
          bloc: _orderBloc,
          builder: (context, OrderState state) {
            if (state is LoadingOrderState) {
              return SizedLoading();
            } else {
              return BlocValidationButton(
                formValidationBloc: _formValidationBloc,
                lable: Translation.of(context).get("buttons/send"),
                onPressedWhenValid: () =>
                    _orderBloc.dispatch(_bookingTokenController.text),
              );
            }
          },
        ),
        SizedBox(width: UiHelper.standard_padding),
      ],
    );
  }

  _setUpOrderResponses(OrderBloc orderBloc) {
    orderBloc.state.listen((OrderState state) {
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
