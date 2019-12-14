import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_thai_star_flutter/blocs/booking_bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_order_bloc.dart';
import 'package:my_thai_star_flutter/router.dart';
import 'package:my_thai_star_flutter/blocs/simple_bloc_delegate.dart';
import 'package:bloc/bloc.dart';
import 'package:my_thai_star_flutter/ui/theme.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
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
      ],
      child: MaterialApp(
        title: 'My Thai Star',
        theme: themeData,
        initialRoute: Router.home,
        routes: Router.routeMap,
      ),
    );
  }
}
