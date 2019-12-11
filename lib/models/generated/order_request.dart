import 'package:my_thai_star_flutter/models/dish.dart';
import 'package:my_thai_star_flutter/models/order.dart';

///Generated with https://javiercbk.github.io/json_to_dart/
class OrderRequest {
  BookingNumber booking;
  List<OrderLine> orderLines;

  OrderRequest({this.booking, this.orderLines});

  OrderRequest.fromJson(Map<String, dynamic> json) {
    booking = json['booking'] != null
        ? new BookingNumber.fromJson(json['booking'])
        : null;
    if (json['orderLines'] != null) {
      orderLines = new List<OrderLine>();
      json['orderLines'].forEach((v) {
        orderLines.add(new OrderLine.fromJson(v));
      });
    }
  }
  OrderRequest.fromOrder(Order order) {
    booking = BookingNumber(bookingToken: order.bookingCode);
    orderLines = List();
    order.dishes.forEach((Dish dish, int amount) {
      OrderDishData dishData = OrderDishData(amount: amount, dishId: dish.id);
      List<Extras> extras = List();

      dish.extras.forEach((extra, picked) {
        if (picked) {
          extras.add(Extras(id: extra.id));
        }
      });

      orderLines.add(OrderLine(dishData: dishData, extras: extras));
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.booking != null) {
      data['booking'] = this.booking.toJson();
    }
    if (this.orderLines != null) {
      data['orderLines'] = this.orderLines.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BookingNumber {
  String bookingToken;

  BookingNumber({this.bookingToken});

  BookingNumber.fromJson(Map<String, dynamic> json) {
    bookingToken = json['bookingToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookingToken'] = this.bookingToken;
    return data;
  }
}

class OrderLine {
  OrderDishData dishData;
  List<Extras> extras;

  OrderLine({this.dishData, this.extras});

  OrderLine.fromJson(Map<String, dynamic> json) {
    dishData = json['orderLine'] != null
        ? new OrderDishData.fromJson(json['orderLine'])
        : null;
    if (json['extras'] != null) {
      extras = new List<Extras>();
      json['extras'].forEach((v) {
        extras.add(new Extras.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dishData != null) {
      data['orderLine'] = this.dishData.toJson();
    }
    if (this.extras != null) {
      data['extras'] = this.extras.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderDishData {
  int dishId;
  int amount;
  String comment;

  OrderDishData({this.dishId, this.amount, this.comment});

  OrderDishData.fromJson(Map<String, dynamic> json) {
    dishId = json['dishId'];
    amount = json['amount'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dishId'] = this.dishId;
    data['amount'] = this.amount;
    data['comment'] = this.comment;
    return data;
  }
}

class Extras {
  int id;

  Extras({this.id});

  Extras.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}
