class Booking {
  String date;
  String name;
  String organizerEmail;
  int guests;
  bool termsAccepted;
  List<String> inviteEmails;

  Booking({
    this.date,
    this.name,
    this.organizerEmail,
    this.guests,
    this.termsAccepted,
    this.inviteEmails,
  });
}
