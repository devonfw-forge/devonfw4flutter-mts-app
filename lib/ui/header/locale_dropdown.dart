import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_thai_star_flutter/blocs/localization_bloc.dart';
import 'package:my_thai_star_flutter/localization.dart';

///Defines the [DropdownButton] that allows the selection of a [Locale]/Language
class LocaleDropDown extends StatelessWidget {
  static const double _paddingRight = 15;
  static const double _paddingLeft = 10;
  static const double _flagHeight = 15;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationBloc, Locale>(
      builder: (context, currentLocale) => Padding(
        padding: EdgeInsets.only(right: _paddingRight, left: _paddingLeft),
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Theme.of(context).backgroundColor,
          ),
          child: DropdownButton<String>(
            underline: SizedBox(), //remove default underline
            iconSize: 0.0, //remove default arrow icon
            value: currentLocale.languageCode,
            items: _mapDropDownItems(context),
            onChanged: (String locale) =>
                BlocProvider.of<LocalizationBloc>(context)
                    .dispatch(Locale(locale)),
          ),
        ),
      ),
    );
  }

  ///Generates the [DropdownMenuItem]s base on
  ///[MtsLocalizationDelegate.supportedLanguages].
  ///
  ///Country flags are provided by the 'country_icons' package.
  List<DropdownMenuItem<String>> _mapDropDownItems(BuildContext context) {
    return MtsLocalizationDelegate.supportedLanguages
        .map<DropdownMenuItem<String>>(
      (String code) {
        //'en' is not defined as an Icon be the country_icons package,
        //So we overwrite it here
        String assetName = code;
        if (code == 'en') assetName = 'gb';

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
