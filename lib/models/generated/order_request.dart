///Generated with https://javiercbk.github.io/json_to_dart/
class OrderRequest {
  BookingNumber booking;
  List<OrderLines> orderLines;

  OrderRequest({this.booking, this.orderLines});

  OrderRequest.fromJson(Map<String, dynamic> json) {
    booking =
        json['booking'] != null ? new BookingNumber.fromJson(json['booking']) : null;
    if (json['orderLines'] != null) {
      orderLines = new List<OrderLines>();
      json['orderLines'].forEach((v) {
        orderLines.add(new OrderLines.fromJson(v));
      });
    }
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

class OrderLines {
  OrderLine orderLine;
  List<Extras> extras;

  OrderLines({this.orderLine, this.extras});

  OrderLines.fromJson(Map<String, dynamic> json) {
    orderLine = json['orderLine'] != null
        ? new OrderLine.fromJson(json['orderLine'])
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
    if (this.orderLine != null) {
      data['orderLine'] = this.orderLine.toJson();
    }
    if (this.extras != null) {
      data['extras'] = this.extras.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderLine {
  int dishId;
  int amount;
  String comment;

  OrderLine({this.dishId, this.amount, this.comment});

  OrderLine.fromJson(Map<String, dynamic> json) {
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