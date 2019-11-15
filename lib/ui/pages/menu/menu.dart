import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/models/dish.dart';
import 'package:my_thai_star_flutter/ui/pages/menu/dish_card.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/app_drawer.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/custom_app_bar.dart';

class Menu extends StatelessWidget {
  final List<Dish> dishes = [
    Dish(
        name: "THAI GREEN CHICKEN CURRY",
        description: "Master this aromatic, creamy & extremely tasty" +
            " chicken Thai green curry recipe from Jamie Oliver & treat" +
            " yourself to an authentic taste of South East Asia.",
        price: 14.75,
        imageLocation: "assets/images/green-curry.jpg",
        extras: ["Tofu", "Extra Curry",]),
    Dish(
        name: "THAI SPICY BASIL FRIED RICE",
        description: "Master this aromatic, creamy & extremely tasty" +
            " chicken Thai green curry recipe from Jamie Oliver & treat" +
            " yourself to an authentic taste of South East Asia.",
        price: 12.99,
        imageLocation: "assets/images/green-curry.jpg",
        extras: ["Tofu", "Extra Curry"]),
  ];

  Menu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: Theme.of(context).backgroundColor,
      drawer: AppDrawer(),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: dishes.length,
        itemBuilder: (context, index) {
          return DishCard(
            dish: dishes[index],
          );
        },
      ),
    );
  }
}
