import 'package:my_thai_star_flutter/models/dish.dart';
import 'package:my_thai_star_flutter/models/extra.dart';

class DummyData {
  static final List<Dish> dishes = [
    Dish(
      id: 1,
      name: "MOCK CHICKEN CURRY",
      description: "Master this aromatic, creamy & extremely fake.",
      price: 14.75,
      assetImage: "assets/images/green-curry.jpg",
      extras: {
        Extra(id: 1, name: "Tofu"): false,
        Extra(id: 2, name: "Extra Curry"): false,
      },
    ),
    Dish(
      id: 2,
      name: "MOCK SPICY BASIL FRIED RICE",
      description: "This would be a staple of Thai cooking. " +
          "If only this wasn't a fake dish.",
      price: 12.99,
      assetImage: "assets/images/basil-fried.jpg",
      extras: {
        Extra(id: 1, name: "Tofu"): false,
        Extra(id: 2, name: "Extra Curry"): false,
      },
    ),
  ];
}
