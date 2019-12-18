import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_thai_star_flutter/blocs/localization_bloc.dart';
import 'package:my_thai_star_flutter/blocs/localization_state.dart';

class LocaleDropDown extends StatelessWidget {
  static const double _paddingRight = 15;
  static const double _paddingLeft = 10;
  static const double _flagHeight = 15;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationBloc, LocalizationState>(
      builder: (context, state) => Padding(
        padding: EdgeInsets.only(right: _paddingRight, left: _paddingLeft),
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Theme.of(context).backgroundColor,
          ),
          child: DropdownButton<String>(
            underline: SizedBox(),
            iconSize: 0.0,
            value: state.languageCode,
            items: _mapDropDownItems(context),
            onChanged: (String locale) =>
                BlocProvider.of<LocalizationBloc>(context)
                    .dispatch(Locale(locale)),
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> _mapDropDownItems(BuildContext context) {
    return LocalizationBloc.supportedLanguages.map<DropdownMenuItem<String>>(
      (String code) {
        String assetName = code;
        if (code == "en") assetName = "gb";

        return DropdownMenuItem<String>(
          value: code,
          child: Center(
            child: Image.asset(
              'icons/flags/png/$assetName.png',
              package: 'country_icons',
              height: _flagHeight,
            ),
          ),
        );
      },
    ).toList();
  }
}
