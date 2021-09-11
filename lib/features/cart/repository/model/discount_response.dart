class DiscountResponse {
  String? _type;
  String? _message;
  num? _discount;

  String? get type => _type;
  String? get message => _message;
  num? get discount => _discount;

  DiscountResponse({
      String? type, 
      String? message, 
      num? discount}){
    _type = type;
    _message = message;
    _discount = discount;
}

  DiscountResponse.fromJson(dynamic json) {
    _type = json['type'];
    _message = json['message'];
    _discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['type'] = _type;
    map['message'] = _message;
    map['discount'] = _discount;
    return map;
  }

}