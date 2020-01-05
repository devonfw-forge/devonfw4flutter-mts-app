import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_thai_star_flutter/root_provider.dart';
import 'package:my_thai_star_flutter/blocs/localization_bloc.dart';
import 'package:my_thai_star_flutter/blocs/loging_bloc_delegate.dart';
import 'package:my_thai_star_flutter/localization.dart';
import 'package:my_thai_star_flutter/ui/router.dart';
import 'package:bloc/bloc.dart';
import 'package:my_thai_star_flutter/ui/mts_theme.dart';

///Runs the application & set's up logging
void main() {
  //Logging
  BlocSupervisor.delegate = LogingBlocDelegate();

  runApp(MyThaiStar());
}

///Defines the root of the Application
///
///Re-builds the app when a new [Locale] is selected.
///When the [LocalizationBloc] emits a new [Locale], the application-
///wide [Locale] is set in the [MaterialApp] & all localized texts
///are updated.
///Set's up [RootProvider] to globally provide a set of [Bloc]s &
///the [RepositoryBundle].
class MyThaiStar extends StatelessWidget {
  static const String title = 'My Thai Star';

  @override
  Widget build(BuildContext context) {
    return RootProvider(
      child: BlocBuilder<LocalizationBloc, Locale>(
        builder: (context, locale) => MaterialApp(
          title: title,
          theme: MtsTheme.data,
          locale: locale,
          initialRoute: Router.home,
          onGenerateRoute: (RouteSettings settings) =>
              Router.generateRoute(settings),
          localizationsDelegates: _buildLocalizationDelegates(),
          supportedLocales: MtsLocalizationDelegate.supportedLanguages
              .map((code) => Locale(code))
              .toList(),
        ),
      ),
    );
  }

  ///Build a set of [LocalizationsDelegate]
  ///
  ///The list contains both Flutters own [LocalizationsDelegate] for
  ///Widgets etc. and out own [MtsLocalizationDelegate].
  Iterable<LocalizationsDelegate<dynamic>> _buildLocalizationDelegates() => [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        //This is our own Delegate for handeling localized text
        MtsLocalizationDelegate(),
      ];
}
