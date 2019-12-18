import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_thai_star_flutter/blocs/booking_bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_order_bloc.dart';
import 'package:my_thai_star_flutter/blocs/localization_bloc.dart';
import 'package:my_thai_star_flutter/blocs/localization_state.dart';
import 'package:my_thai_star_flutter/blocs/loging_bloc_delegate.dart';
import 'package:my_thai_star_flutter/router.dart';
import 'package:bloc/bloc.dart';
import 'package:my_thai_star_flutter/ui/theme.dart';

void main() {
  BlocSupervisor.delegate = LogingBlocDelegate();
  runApp(MyThaiStar());
}

class MyThaiStar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CurrentOrderBloc>(
          builder: (BuildContext context) => CurrentOrderBloc(),
        ),
        BlocProvider<BookingBloc>(
          builder: (BuildContext context) => BookingBloc(),
        ),
        BlocProvider<LocalizationBloc>(
          builder: (BuildContext context) => LocalizationBloc(),
        ),
      ],
      child: BlocBuilder<LocalizationBloc, LocalizationState>(
        builder: (context, state) {
          if (state is IdleLocalizationState) {
            return MaterialApp(
              title: 'My Thai Star',
              theme: themeData,
              locale: state.locale,
              initialRoute: Router.home,
              onGenerateRoute: (RouteSettings settings) =>
                  Router.generateRoute(settings),
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: LocalizationBloc.supportedLanguages
                  .map((code) => Locale(code))
                  .toList(),
            );
          } else {
            BlocProvider.of<LocalizationBloc>(context).dispatch(Locale("en"));
            return Container(
                color: Colors.white,
                child: Center(
                  child: CircularProgressIndicator(),
                ));
          }
        },
      ),
    );
  }
}
