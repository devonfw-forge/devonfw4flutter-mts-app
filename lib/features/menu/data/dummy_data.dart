import 'package:my_thai_star_flutter/features/menu/models/dish.dart';
import 'package:my_thai_star_flutter/features/menu/models/extra.dart';

class DummyData {
  static final List<Dish> dishes = [
    Dish(
      name: "THAI GREEN CHICKEN CURRY",
      description: "Master this aromatic, creamy & extremely tasty" +
          " chicken Thai green curry recipe from Jamie Oliver & treat" +
          " yourself to an authentic taste of South East Asia.",
      price: 14.75,
      assetImage: "assets/images/green-curry.jpg",
      extras: {
        Extra(id: 1, name: "Tofu"): false,
        Extra(id: 2, name: "Extra Curry"): false,
      },
      comment: "",
    ),
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
      assetImage: "assets/images/basil-fried.jpg",
      extras: {
        Extra(id: 1, name: "Tofu"): false,
        Extra(id: 2, name: "Extra Curry"): false,
      },
      comment: "",
    ),
  ];
}
