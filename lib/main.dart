import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_thai_star_flutter/features/current_order/blocs/current_order_bloc.dart';
import 'package:my_thai_star_flutter/router.dart';
import 'theme.dart';

void main() => runApp(MyThaiStar());

class MyThaiStar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (BuildContext context) => CurrentOrderBloc(),
      child: MaterialApp(
        title: 'My Thai Star',
        theme: themeData,
        initialRoute: Router.home,
        routes: Router.routeMap,
      ),
    );
  }
}
