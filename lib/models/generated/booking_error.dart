///Defines one error that can be received as a json from the MyThaiStar Api.
///
///Error can accrue when sending a [BookingRequest]
///Generated with https://javiercbk.github.io/json_to_dart/
class BookingError {
  String code;
  String message;
  String uuid;
  Errors errors;

  BookingError({this.code, this.message, this.uuid, this.errors});

  BookingError.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    uuid = json['uuid'];
    errors =
        json['errors'] != null ? new Errors.fromJson(json['errors']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['uuid'] = this.uuid;
    if (this.errors != null) {
      data['errors'] = this.errors.toJson();
    }
    return data;
  }
}

class Errors {
  List<String> bookingDate;

  Errors({this.bookingDate});

  Errors.fromJson(Map<String, dynamic> json) {
    bookingDate = json['bookingDate'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookingDate'] = this.bookingDate;
    return data;
  }
}
