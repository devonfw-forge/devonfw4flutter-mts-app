import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_order_bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_order_state.dart';
import 'package:my_thai_star_flutter/blocs/localization_bloc.dart';
import 'package:my_thai_star_flutter/ui/ui_helper.dart';

class TotalPriceDisplay extends StatelessWidget {
  const TotalPriceDisplay({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(UiHelper.standard_padding),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(LocalizationBloc.of(context).get("formFields/total"),
              style: Theme.of(context)
                  .textTheme
                  .title
                  .copyWith(color: Colors.black)),
          BlocBuilder<CurrentOrderBloc, CurrentOrderState>(
              builder: (context, state) => Text(
                    "${state.formattedTotalPrice} €",
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(color: Colors.black),
                  )),
        ],
      ),
    );
  }
}
