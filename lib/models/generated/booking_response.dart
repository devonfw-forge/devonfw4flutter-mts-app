///Generated with https://javiercbk.github.io/json_to_dart/
class BookingResponse {
  int id;
  int modificationCounter;
  String name;
  String bookingToken;
  String comment;
  int bookingDate;
  int expirationDate;
  double creationDate;
  String email;
  bool canceled;
  String bookingType;
  String tableId;
  String orderId;
  int assistants;
  String userId;

  BookingResponse(
      {this.id,
      this.modificationCounter,
      this.name,
      this.bookingToken,
      this.comment,
      this.bookingDate,
      this.expirationDate,
      this.creationDate,
      this.email,
      this.canceled,
      this.bookingType,
      this.tableId,
      this.orderId,
      this.assistants,
      this.userId});

  BookingResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    modificationCounter = json['modificationCounter'];
    name = json['name'];
    bookingToken = json['bookingToken'];
    comment = json['comment'];
    bookingDate = json['bookingDate'];
    expirationDate = json['expirationDate'];
    creationDate = json['creationDate'];
    email = json['email'];
    canceled = json['canceled'];
    bookingType = json['bookingType'];
    tableId = json['tableId'];
    orderId = json['orderId'];
    assistants = json['assistants'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['modificationCounter'] = this.modificationCounter;
    data['name'] = this.name;
    data['bookingToken'] = this.bookingToken;
    data['comment'] = this.comment;
    data['bookingDate'] = this.bookingDate;
    data['expirationDate'] = this.expirationDate;
    data['creationDate'] = this.creationDate;
    data['email'] = this.email;
    data['canceled'] = this.canceled;
    data['bookingType'] = this.bookingType;
    data['tableId'] = this.tableId;
    data['orderId'] = this.orderId;
    data['assistants'] = this.assistants;
    data['userId'] = this.userId;
    return data;
  }
}
