class FavouriteResponse {
  String? _type;
  String? _message;
  Favorite? _favorite;

  String? get type => _type;
  String? get message => _message;
  Favorite? get favorite => _favorite;

  FavouriteResponse({
      String? type, 
      String? message, 
      Favorite? favorite}){
    _type = type;
    _message = message;
    _favorite = favorite;
}

  FavouriteResponse.fromJson(dynamic json) {
    _type = json['type'];
    _message = json['message'];
    _favorite = json['favorite'] != null ? Favorite.fromJson(json['favorite']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['type'] = _type;
    map['message'] = _message;
    if (_favorite != null) {
      map['favorite'] = _favorite?.toJson();
    }
    return map;
  }

}

class Favorite {
  String? _id;
  String? _user;
  List<String>? _products;

  String? get id => _id;
  String? get user => _user;
  List<String>? get products => _products;

  Favorite({
      String? id, 
      String? user, 
      List<String>? products}){
    _id = id;
    _user = user;
    _products = products;
}

  Favorite.fromJson(dynamic json) {
    _id = json['_id'];
    _user = json['user'];
    _products = json['products'] != null ? json['products'].cast<String>() : [];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['_id'] = _id;
    map['user'] = _user;
    map['products'] = _products;
    return map;
  }

}