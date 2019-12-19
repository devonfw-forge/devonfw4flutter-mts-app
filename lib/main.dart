import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_thai_star_flutter/blocs/booking_bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_order_bloc.dart';
import 'package:my_thai_star_flutter/blocs/localization_bloc.dart';
import 'package:my_thai_star_flutter/blocs/loging_bloc_delegate.dart';
import 'package:my_thai_star_flutter/localization/mts-localization-delegate.dart';
import 'package:my_thai_star_flutter/ui/router.dart';
import 'package:bloc/bloc.dart';
import 'package:my_thai_star_flutter/ui/mts_theme.dart';

void main() {
  BlocSupervisor.delegate = LogingBlocDelegate();
  runApp(MyThaiStar());
}

///Globally provides a set of [Bloc]s, Re-builds app when a new
///[Locale] is selected 
///
///Root of the App. This is the only place where [Bloc]s can be
///provided to multiple pages.
///When the [LocalizationBloc] emits a new [Locale], the application-
///wide [Locale] is set in the [MaterialApp] & all localized texts
///are updated.
class MyThaiStar extends StatelessWidget {
  static const String title = 'My Thai Star';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: _buildGlobalProvider(),
      child: BlocBuilder<LocalizationBloc, Locale>(
        builder: (context, locale) => MaterialApp(
          title: title,
          theme: MtsTheme.get(),
          locale: locale,
          initialRoute: Router.home,
          onGenerateRoute: (RouteSettings settings) =>
              Router.generateRoute(settings),
          localizationsDelegates: [
            //Flutter ships with Localized versions of their Widgets.
            //This is where we define that they should change based on
            //the [MaterialApp.locale] value we set.
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            //This is our own Delegate for handeling localized text
            MtsLocalizationDelegate(),
          ],
          supportedLocales: MtsLocalizationDelegate.supportedLanguages
              .map((code) => Locale(code))
              .toList(),
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
          builder: (BuildContext context) => BookingBloc(),
        ),
        BlocProvider<LocalizationBloc>(
          builder: (BuildContext context) => LocalizationBloc(),
        ),
      ];
}
