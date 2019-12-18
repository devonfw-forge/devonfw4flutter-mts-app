import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_search_bloc.dart';
import 'package:my_thai_star_flutter/blocs/dish_bloc.dart';
import 'package:my_thai_star_flutter/blocs/dish_state.dart';
import 'package:my_thai_star_flutter/ui/header/header.dart';
import 'package:my_thai_star_flutter/ui/menu/dish_card.dart';
import 'package:my_thai_star_flutter/ui/menu/sliver_search_header.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/app_drawer.dart';
import 'package:my_thai_star_flutter/ui/ui_helper.dart';

class MenuPage extends StatefulWidget {

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  DishBloc _dishBloc;
  CurrentSearchBloc _searchBloc;

  @override
  void initState() {
    _searchBloc = CurrentSearchBloc();
    _dishBloc = DishBloc(_searchBloc);

    _dishBloc.dispatch(DishEvents.request);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      drawer: AppDrawer(),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<CurrentSearchBloc>(
            builder: (BuildContext context) => _searchBloc,
          ),
          BlocProvider<DishBloc>(
            builder: (BuildContext context) => _dishBloc,
          ),
        ],
        child: CustomScrollView(
          slivers: <Widget>[
            SliverSearchHeader(),
            BlocBuilder<DishBloc, DishState>(
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
            SliverToBoxAdapter(
              child: SizedBox(height: UiHelper.standard_padding),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loading() {
    return SliverFillRemaining(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _error(ErrorDishState state) {
    return SliverFillRemaining(
      child: Center(
        child: Text(state.errorMessage),
      ),
    );
  }

  Widget _list(ReceivedDishState state) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) => DishCard(
          dish: state.dishes[index],
        ),
        childCount: state.dishes.length,
      ),
    );
  }

  @override
  void dispose() {
    _dishBloc.dispose();
    _searchBloc.dispose();
    super.dispose();
  }
}
