import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_bloc/barrel.dart';
import 'package:my_thai_star_flutter/localization/translation.dart';
import 'package:my_thai_star_flutter/blocs/order_bloc.dart';
import 'package:my_thai_star_flutter/blocs/order_state.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/form/bloc_validation_button.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/sized_loading.dart';
import 'package:my_thai_star_flutter/ui/ui_helper.dart';

class OrderFormButtons extends StatelessWidget {
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
          builder: (context, OrderState state) {
            if (state is LoadingOrderState) {
              return SizedLoading();
            } else {
              return BlocValidationButton(
                formValidationBloc: _formValidationBloc,
                lable: Translation.of(context).get("buttons/send"),
                onPressedWhenValid: () => BlocProvider.of<OrderBloc>(context)
                    .dispatch(_bookingTokenController.text),
              );
            }
          },
        ),
        SizedBox(width: UiHelper.standard_padding),
      ],
    );
  }
}