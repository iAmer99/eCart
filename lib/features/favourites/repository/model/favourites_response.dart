class FavouritesResponse {
  String? _type;
  String? _message;
  List<String>? _products;

  String? get type => _type;
  String? get message => _message;
  List<String>? get products => _products;

  FavouritesResponse({
      String? type, 
      String? message, 
      List<String>? products}){
    _type = type;
    _message = message;
    _products = products;
}

  FavouritesResponse.fromJson(dynamic json) {
    _type = json['type'];
    _message = json['message'];
    _products = json['products'] != null ? json['products'].cast<String>() : [];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['type'] = _type;
    map['message'] = _message;
    map['products'] = _products;
    return map;
  }

}