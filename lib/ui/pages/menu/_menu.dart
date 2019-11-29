import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  DishBloc dishBloc = DishBloc();

  @override
  void initState() {
    dishBloc.dispatch(Search());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: Theme.of(context).backgroundColor,
      drawer: AppDrawer(),
      body: BlocProvider(
        builder: (BuildContext context) => dishBloc,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverSearchHeader(),
            BlocBuilder(
              bloc: dishBloc,
              builder: (context, DishState state) {
                //This is where we determine the State of the Wisdom BLoC
                if (state is ErrorDishState)
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text(state.error),
                    ),
                  );
                  
                if (state is IdleDishState) {
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
                return CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    dishBloc.dispose();
    super.dispose();
  }
}
