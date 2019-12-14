import 'package:intl/intl.dart';

class Booking {
  static final DateFormat dateFormat = DateFormat("dd-MM-yyyy HH:mm");

  DateTime date;
  String name;
  String organizerEmail;
  int guests;
  bool termsAccepted;

  Booking({
    this.date,
    this.name,
    this.organizerEmail,
    this.guests,
    this.termsAccepted
  });

  Booking copyWith({
    DateTime date,
    String name,
    String organizerEmail,
    int guests,
    bool termsAccepted,
  }) =>
      Booking(
        date: date ?? this.date,
        name: name ?? this.name,
        organizerEmail: organizerEmail ?? this.organizerEmail,
        guests: guests ?? this.guests,
        termsAccepted: termsAccepted ?? this.termsAccepted,
      );
}
