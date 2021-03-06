///Defines one response that can be received as a json from the MyThaiStar Api.
///
///The response can be received after sending a [OrderRequest].
///This Response confirms the order.
///Generated with https://javiercbk.github.io/json_to_dart/
class OrderResponse {
  int id;
  int modificationCounter;
  int orderId;
  int invitedGuestId;
  String bookingToken;
  int hostId;

  OrderResponse(
      {this.id,
      this.modificationCounter,
      this.orderId,
      this.invitedGuestId,
      this.bookingToken,
      this.hostId});

  OrderResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    modificationCounter = json['modificationCounter'];
    orderId = json['orderId'];
    invitedGuestId = json['invitedGuestId'];
    bookingToken = json['bookingToken'];
    hostId = json['hostId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['modificationCounter'] = this.modificationCounter;
    data['orderId'] = this.orderId;
    data['invitedGuestId'] = this.invitedGuestId;
    data['bookingToken'] = this.bookingToken;
    data['hostId'] = this.hostId;
    return data;
  }
}
