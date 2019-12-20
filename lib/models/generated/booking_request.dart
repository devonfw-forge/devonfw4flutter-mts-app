import 'package:my_thai_star_flutter/models/booking.dart';

import 'package:intl/intl.dart';

///Defines one request that can be send as a json to the MyThaiStar Api.
///
///The request places one booking.
///Can be generated from a [Booking].
///The dependency goes from generated class to domain class
///to keep the domain class as clean as possible.
///Generated with https://javiercbk.github.io/json_to_dart/
class BookingRequest {
  BookingRequestPayload booking;

  BookingRequest({this.booking});

  BookingRequest.fromJson(Map<String, dynamic> json) {
    booking = json['booking'] != null
        ? new BookingRequestPayload.fromJson(json['booking'])
        : null;
  }
  BookingRequest.fromBooking(Booking b) {
    booking = BookingRequestPayload(
      bookingDate: _formatDate(b.date),
      name: b.name,
      email: b.organizerEmail,
      assistants: b.guests,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.booking != null) {
      data['booking'] = this.booking.toJson();
    }
    return data;
  }
}

class BookingRequestPayload {
  String bookingDate;
  String name;
  String email;
  int assistants;

  BookingRequestPayload(
      {this.bookingDate, this.name, this.email, this.assistants});

  BookingRequestPayload.fromJson(Map<String, dynamic> json) {
    bookingDate = json['bookingDate'];
    name = json['name'];
    email = json['email'];
    assistants = json['assistants'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookingDate'] = this.bookingDate;
    data['name'] = this.name;
    data['email'] = this.email;
    data['assistants'] = this.assistants;
    return data;
  }
}

///Formates a given [DateTime] to the format required by the
///MyThaiStar Back-end
String _formatDate(DateTime original) {
  DateFormat newFormat = DateFormat("yyyy-MM-ddTHH:mm:ss.SSS'Z'");
  return newFormat.format(original);
}
