import 'package:intl/intl.dart';

class Booking{
  static final DateFormat dateFormat = DateFormat("dd-MM-yyyy HH:mm");
  
  String date;
  String name;
  String organizerEmail;
  int guests;
  List<String> inviteEmails;

  Booking({
    this.date,
    this.name,
    this.organizerEmail,
    this.guests,
    this.inviteEmails,
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
