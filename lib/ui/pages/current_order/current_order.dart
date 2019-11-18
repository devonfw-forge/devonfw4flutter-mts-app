import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/models/dish.dart';
import 'package:my_thai_star_flutter/ui/pages/current_order/alert_card.dart';
import 'package:my_thai_star_flutter/ui/pages/current_order/dish_slip.dart';
import 'package:my_thai_star_flutter/ui/pages/current_order/dish_slip_list.dart';
import 'package:my_thai_star_flutter/ui/pages/current_order/resume_header.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/app_drawer.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/custom_app_bar.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/labeled_checkbox.dart';
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
      backgroundColor: Colors.white,
      drawer: AppDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ResumeHeader(),
          DishSlipList(dishes: dishes),
          AlertCard(),
          Padding(
            padding: const EdgeInsets.only(
              right: UiHelper.standart_padding,
              left: UiHelper.standart_padding,
            ),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Booking ID",
              ),
            ),
          ),
          LabeledCheckBox(
            label: "Accept Terms",
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                child: Text(
                  "CANCEL",
                  style: Theme.of(context).textTheme.button.copyWith(
                        color: Colors.grey,
                      ),
                ),
                onPressed: () {},
              ),
              SizedBox(width: UiHelper.standart_padding),
              FlatButton(
                child: Text(
                  "SEND",
                  style: Theme.of(context).textTheme.button.copyWith(
                        color: Theme.of(context).accentColor,
                      ),
                ),
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}
