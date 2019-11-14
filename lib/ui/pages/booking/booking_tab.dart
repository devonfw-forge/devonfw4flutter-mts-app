import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/ui/pages/booking/custom_form_card.dart';
import 'booking_form.dart';

class BookingTab extends StatelessWidget {
  static const imageLocation = "assets/images/slider-1.jpg";

  const BookingTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomFormCard(
      headerImageLocation: imageLocation,
      children: <Widget>[
        Text(
          "BOOK YOUR TABLE",
          textAlign: TextAlign.left,
          style: Theme.of(context)
              .textTheme
              .title
              .copyWith(color: Colors.black, fontWeight: FontWeight.normal),
        ),
        Text(
          "You can book a table and an order menu",
          style:
              Theme.of(context).textTheme.subtitle.copyWith(color: Colors.grey),
        ),
        BookingForm(),
      ],
    );
  }
}
