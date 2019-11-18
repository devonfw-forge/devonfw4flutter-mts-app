import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/models/dish.dart';
import 'package:my_thai_star_flutter/ui/pages/current_order/dish_slip.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/app_drawer.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/custom_app_bar.dart';
import 'package:my_thai_star_flutter/ui/ui_helper.dart';

class CurrentOrder extends StatelessWidget {
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

  CurrentOrder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: Theme.of(context).backgroundColor,
      drawer: AppDrawer(),
      body: Column(
        children: <Widget>[
          ListTile(
            title: Text("RESUME BOOKING"),
            leading: IconButton(
              icon: Icon(Icons.cancel),
            ),
          ),
          Container(
            padding: EdgeInsets.all(UiHelper.standart_padding),
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(color: Colors.white),
            child: Text("ORDER MENU"),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index < dishes.length
                    ? DishSlip(
                        dish: dishes[index],
                      )
                    : null;
              },
            ),
          )
        ],
      ),
    );
  }
}
