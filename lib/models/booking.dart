class Booking{
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
          'assistants' : guests + 1,
          'bookingDate' : date.toString(),
          'email' : organizerEmail,
          'name' : name
        }
      };
}
