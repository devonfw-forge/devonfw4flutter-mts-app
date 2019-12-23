import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_thai_star_flutter/blocs/booking_bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_order_bloc.dart';
import 'package:my_thai_star_flutter/blocs/localization_bloc.dart';
import 'package:my_thai_star_flutter/blocs/loging_bloc_delegate.dart';
import 'package:my_thai_star_flutter/localization.dart';
import 'package:my_thai_star_flutter/repositories/repository_bundle.dart';
import 'package:my_thai_star_flutter/ui/router.dart';
import 'package:bloc/bloc.dart';
import 'package:my_thai_star_flutter/ui/mts_theme.dart';
import 'package:yaml/yaml.dart';
import 'dart:io';

Map<dynamic, dynamic> _config;

///Runs the application, set's up logging and loads the configurations
///
///Responsible for setting up logging for our [Bloc]s &
///for loading the configurations form the `/config.yaml`.
///These 2 things need to happen **before** we load application,
///that's why we are doing them here.
void main() async {
  //Logging
  BlocSupervisor.delegate = LogingBlocDelegate();

  //Config
  String configString = await File("../config.yaml").readAsString();
  _config = loadYaml(configString);

  runApp(MyThaiStar());
}

///Defines the root of the Application and is responsible for setting up a few things
///before the WidgetTree is build
///
///#### Responsibilities:
/// - Globally provides a set of [Bloc]s
/// - Re-builds the app when a new [Locale] is selected
/// - Sets up and provides the [RepositoryBundle] to
///   enable dependency injection
///
///When the [LocalizationBloc] emits a new [Locale], the application-
///wide [Locale] is set in the [MaterialApp] & all localized texts
///are updated.
class MyThaiStar extends StatelessWidget {
  static const String title = 'My Thai Star';

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<RepositoryBundle>(
      //Provide Repositories Globally
      builder: (context) => RepositoryBundle(
        mock: _config["use_mock_data"],
        baseUrl: _config["service_base_url"],
      ),
      child: MultiBlocProvider(
        providers: _buildGlobalProvider(),
        child: BlocBuilder<LocalizationBloc, Locale>(
          builder: (context, locale) => MaterialApp(
            title: title,
            theme: MtsTheme.get(),
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
      ),
    );
  }

  ///Builds the global [BlocProvider]s
  ///
  ///We need to provide these globally because:
  ///The [CurrentOrderBloc] is needed by the [Header] to display the current amount
  ///of [Dish]es in the order, by the [OrderPage] to display the [Dish]es in the
  ///order & by the [MenuPage] to add new [Dish]es to the order.
  ///
  ///The [BookingBloc] is needed by the [BookingPage] to place a new booking &
  ///by the [OrderPage] to auto fill-in the booking token.
  ///
  ///The [LocalizationBloc] is needed by the [Header] to set a new [Locale] &
  ///by the [MaterialApp] to update the current [Locale].
  List<BlocProvider<Bloc<dynamic, dynamic>>> _buildGlobalProvider() => [
        BlocProvider<CurrentOrderBloc>(
          builder: (BuildContext context) => CurrentOrderBloc(),
        ),
        BlocProvider<BookingBloc>(
          builder: (BuildContext context) => BookingBloc(
            bookingService:
                RepositoryProvider.of<RepositoryBundle>(context).booking,
          ),
        ),
        BlocProvider<LocalizationBloc>(
          builder: (BuildContext context) => LocalizationBloc(),
        ),
      ];

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
