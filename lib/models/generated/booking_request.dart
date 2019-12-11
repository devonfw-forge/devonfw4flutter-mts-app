import 'package:my_thai_star_flutter/models/booking.dart';

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
      bookingDate: b.date,
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
