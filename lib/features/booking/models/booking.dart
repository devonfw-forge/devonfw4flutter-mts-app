import 'package:intl/intl.dart';

class Booking {
  static final DateFormat dateFormat = DateFormat("dd-MM-yyyy HH:mm");

  String bookingNumber;
  DateTime date;
  String name;
  String organizerEmail;
  int guests;
  bool termsAccepted;

  Booking({
    this.bookingNumber,
    this.date,
    this.name,
    this.organizerEmail,
    this.guests,
    this.termsAccepted
  });

  Booking copyWith({
    String bookingNumber,
    DateTime date,
    String name,
    String organizerEmail,
    int guests,
    bool termsAccepted,
  }) =>
      Booking(
        bookingNumber: bookingNumber ?? this.bookingNumber,
        date: date ?? this.date,
        name: name ?? this.name,
        organizerEmail: organizerEmail ?? this.organizerEmail,
        guests: guests ?? this.guests,
        termsAccepted: termsAccepted ?? this.termsAccepted,
      );
}
