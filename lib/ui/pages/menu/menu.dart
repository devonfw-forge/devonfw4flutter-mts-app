import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/models/dish.dart';
import 'package:my_thai_star_flutter/ui/pages/menu/dish_card.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/app_drawer.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/custom_app_bar.dart';
import 'package:my_thai_star_flutter/ui/ui_helper.dart';

class Menu extends StatelessWidget {
  final List<Dish> dishes = [
    Dish(
        name: "THAI GREEN CHICKEN CURRY",
        description: "Master this aromatic, creamy & extremely tasty" +
            " chicken Thai green curry recipe from Jamie Oliver & treat" +
            " yourself to an authentic taste of South East Asia.",
        price: 14.75,
        imageLocation: "assets/images/green-curry.jpg",
        extras: [
          "Tofu",
          "Extra Curry",
        ]),
    Dish(
        name: "THAI SPICY BASIL FRIED RICE",
        description: "This is a staple of Thai cooking. " +
            "Adjust the spices to your own tastes for a really " +
            "great use for leftover rice!! I get the basil from a " +
            "local Asian market. It has a different flavor than " +
            "that of regular basil and makes all the difference " +
            "in this recipe. It is fast and fairly easy to make, " +
            "but requires constant stirring",
        price: 12.99,
        imageLocation: "assets/images/basil-fried.jpg",
        extras: ["Tofu", "Extra Curry"]),
  ];

  Menu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: Theme.of(context).backgroundColor,
      drawer: AppDrawer(),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            elevation: UiHelper.elevation,
            floating: true,
            backgroundColor: Colors.white,
            leading: new Container(),
            expandedHeight: 150,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: UiHelper.card_margin, right: UiHelper.card_margin),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          labelText: "Search our Dishes",
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Icon(
                              Icons.sort,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            "Sort by",
                            style: Theme.of(context).textTheme.subhead,
                          ),
                          SizedBox(
                            width: 18,
                          ),
                          Expanded(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: "Name",
                              items: <String>['Price', 'Likes', 'Name']
                                  .map((String value) {
                                return new DropdownMenuItem<String>(
                                  value: value,
                                  child: new Text(value),
                                );
                              }).toList(),
                              onChanged: (_) {},
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.vertical_align_top,
                              color: Theme.of(context).accentColor,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return DishCard(
                dish: dishes[index],
              );
            }),
          ),
        ],
      ),
    );
  }
}
