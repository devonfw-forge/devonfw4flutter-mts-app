import 'package:intl/intl.dart';

class Booking{
  static final DateFormat dateFormat = DateFormat("dd-MM-yyyy HH:mm");
  
  String bookingId;
  String date;
  String name;
  String organizerEmail;
  int guests;

  Booking({
    this.bookingId,
    this.date,
    this.name,
    this.organizerEmail,
    this.guests,
  });

  Map<String, dynamic> toJson() => {
        'booking': {
          'assistants' : guests,
          'bookingDate' : date.toString(),
          'email' : organizerEmail,
          'name' : name
        }
      };
}
