import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_search_bloc.dart';
import 'package:my_thai_star_flutter/blocs/dish_bloc.dart';
import 'package:my_thai_star_flutter/blocs/dish_state.dart';
import 'package:my_thai_star_flutter/models/search.dart';
import 'package:my_thai_star_flutter/ui/pages/menu/dish_card.dart';
import 'package:my_thai_star_flutter/ui/pages/menu/sliver_search_header.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/app_drawer.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/custom_app_bar.dart';

class Menu extends StatefulWidget {
  Menu({Key key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  DishBloc dishBloc;
  CurrentSearchBloc searchBloc;

  @override
  void initState() {
    searchBloc = CurrentSearchBloc();
    dishBloc = DishBloc(searchBloc);

    dishBloc.dispatch(DishEvents.request);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: Theme.of(context).backgroundColor,
      drawer: AppDrawer(),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<CurrentSearchBloc>(
            builder: (BuildContext context) => searchBloc,
          ),
          BlocProvider<DishBloc>(
            builder: (BuildContext context) => dishBloc,
          ),
        ],
        child: CustomScrollView(
          slivers: <Widget>[
            SliverSearchHeader(),
            BlocBuilder(
              bloc: dishBloc,
              builder: (context, DishState state) {
                if (state is ErrorDishState) {
                  return _error(state);
                } else if (state is ReceivedDishState) {
                  return _list(state);
                } else {
                  return _loading();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _loading() {
    return SliverToBoxAdapter(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  SliverToBoxAdapter _error(ErrorDishState state) {
    return SliverToBoxAdapter(
      child: Center(
        child: Text(state.errorMessage),
      ),
    );
  }

  SliverList _list(ReceivedDishState state) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return DishCard(
            dish: state.dishes[index],
          );
        },
        childCount: state.dishes.length,
      ),
    );
  }

  @override
  void dispose() {
    dishBloc.dispose();
    searchBloc.dispose();
    super.dispose();
  }
}
