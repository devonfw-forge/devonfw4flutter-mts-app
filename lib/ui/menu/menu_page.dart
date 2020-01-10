import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_thai_star_flutter/annotation.dart';
import 'package:my_thai_star_flutter/blocs/current_search_bloc.dart';
import 'package:my_thai_star_flutter/blocs/dish_bloc.dart';
import 'package:my_thai_star_flutter/blocs/dish_state.dart';
import 'package:my_thai_star_flutter/repositories/repository_bundle.dart';
import 'package:my_thai_star_flutter/ui/header/header.dart';
import 'package:my_thai_star_flutter/ui/menu/dish_card.dart';
import 'package:my_thai_star_flutter/ui/menu/sliver_search_header.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/app_drawer.dart';
import 'package:my_thai_star_flutter/ui/ui_helper.dart';

///Defines the top-level layout of the Widgets related to the
///menu feature
///
///#### The Menu feature from a top-down view:
///The menu is a list of [Dish]es that are fetched form an external API.
///These dishes can be queried, sorted and added to the current
///order.
///
///#### Provided Blocs:
///The [MenuPage] is responsible for providing the [CurrentSearchBloc] &
///[DishBloc] to it's descendants. The [CurrentSearchBloc] is
///provided here because it is needed by the [SliverSearchHeader]
///to edit the current search and it needs to be
///injected into the [DishBloc] on creation.
///The [DishBloc] is provided here because it is needed by
///[SliverSearchHeader] to request more [Dish]es & by this Widget
///to generate the list of [Dish]es.
///
///#### Relevant Blocs for this feature:
///[DishBloc], [CurrentOrderBloc], [DishCardBloc],
///[CurrentSearchBloc], [CurrentSearchBloc], [LocalizationBloc]
@TopLevelRoute('/menu')
class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  CurrentSearchBloc _searchBloc = CurrentSearchBloc();
  DishBloc _dishBloc;

  @override
  void initState() {
    //Injecting dependencies
    _dishBloc = DishBloc(
      searchBloc: _searchBloc,
      dishService: RepositoryProvider.of<RepositoryBundle>(context).dish,
    );

    //Dispatching initial event
    _dishBloc.dispatch(DishEvent.request);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      drawer: AppDrawer(),
      body: MultiBlocProvider(
        //providing Blocs to descendants
        providers: [
          BlocProvider<CurrentSearchBloc>(
            builder: (BuildContext context) => _searchBloc,
          ),
          BlocProvider<DishBloc>(
            builder: (BuildContext context) => _dishBloc,
          ),
        ],
        child: CustomScrollView(
          //CustomScrollView because it contains Widgets of different types
          slivers: <Widget>[
            SliverSearchHeader(),
            BlocBuilder<DishBloc, DishState>(
              builder: (context, DishState state) {
                //Display List based on state
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

  ///Displays a loading animation wrapped in [SliverFillRemaining]
  Widget _loading() {
    return SliverFillRemaining(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  ///Displays an error message wrapped in [SliverFillRemaining]
  Widget _error(ErrorDishState state) {
    return SliverFillRemaining(
      child: Center(
        child: Text(state.errorMessage),
      ),
    );
  }

  ///Displays a [SliverList] of [DishCard]s
  Widget _list(ReceivedDishState state) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) => DishCard(
          initialDish: state.dishes[index],
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
