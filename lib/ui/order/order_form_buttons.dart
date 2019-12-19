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

///Defines the [Button]s at the bottom of the [OrderForm] & is responsible
///for emitting the BookingToken to the [OrderBloc]
///
///The Send-[Button] dispatches the [TextEditingController.text]
///to the [OrderBloc] when pressed. The Send-[Button] can
///only be pressed when the state of the [FormValidationBloc]
///is [ValidState]. Or in other words, The bookingToken can only be
///dispatched to the [OrderBloc] when the terms are
///accepted a bookingToken has been entered.
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
  State<StatefulWidget> createState() => _OrderFormButtonsState();
}

class _OrderFormButtonsState extends State<OrderFormButtons> {
  OrderBloc _orderBloc;

  @override
  void initState() {
    //Build OrderBloc and inject dependency on CurrentOrderBloc
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
              //Loading Animation while waiting for response
              return SizedLoading();
            } else {
              return BlocValidationButton(
                formValidationBloc: widget._formValidationBloc,
                lable: Translation.of(context).get("buttons/send"),
                onPressedWhenValid: () =>
                    _orderBloc.dispatch(widget._bookingTokenController.text),
              );
            }
          },
        ),
        SizedBox(width: UiHelper.standard_padding),
      ],
    );
  }

  ///Define [ResponseDialog]s that are displayed on order
  ///confirmation and order rejection
  ///
  ///These [String]s are not localized, because this functionality was
  ///not part of the original MyThaStar Angular front-end.
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
