import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_thai_star_flutter/blocs/booking_bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_order_bloc.dart';
import 'package:my_thai_star_flutter/blocs/localization_bloc.dart';
import 'package:my_thai_star_flutter/repositories/repository_bundle.dart';
import 'package:my_thai_star_flutter/configuration.dart';
import 'package:bloc/bloc.dart';

///Provides a set of [Bloc]s and the [RepositoryBundle] globally from the root of the app
class RootProvider extends StatelessWidget {
  final Widget child;
  const RootProvider({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<RepositoryBundle>(
      //Provide Repositories Globally
      builder: (context) => RepositoryBundle(
        mock: Configuration.useMockData,
        baseUrl: Configuration.baseUrl,
      ),
      child: MultiBlocProvider(
        providers: _buildGlobalProvider(),
        child: child,
      ),
    );
  }
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
