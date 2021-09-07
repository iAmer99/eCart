class CartResponse {
  String? _type;
  String? _message;
  Cart? _cart;

  String? get type => _type;
  String? get message => _message;
  Cart? get cart => _cart;

  CartResponse({
      String? type, 
      String? message, 
      Cart? cart}){
    _type = type;
    _message = message;
    _cart = cart;
}

  CartResponse.fromJson(dynamic json) {
    _type = json['type'];
    _message = json['message'];
    _cart = json['cart'] != null ? Cart.fromJson(json['cart']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['type'] = _type;
    map['message'] = _message;
    if (_cart != null) {
      map['cart'] = _cart?.toJson();
    }
    return map;
  }

}

class Cart {
  String? _email;
  List<Items>? _items;
  int? _totalQuantity;
  int? _totalPrice;

  String? get email => _email;
  List<Items>? get items => _items;
  int? get totalQuantity => _totalQuantity;
  int? get totalPrice => _totalPrice;

  Cart({
      String? email, 
      List<Items>? items, 
      int? totalQuantity, 
      int? totalPrice}){
    _email = email;
    _items = items;
    _totalQuantity = totalQuantity;
    _totalPrice = totalPrice;
}

  Cart.fromJson(dynamic json) {
    _email = json['email'];
    if (json['items'] != null) {
      _items = [];
      json['items'].forEach((v) {
        _items?.add(Items.fromJson(v));
      });
    }
    _totalQuantity = json['totalQuantity'];
    _totalPrice = json['totalPrice'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['email'] = _email;
    if (_items != null) {
      map['items'] = _items?.map((v) => v.toJson()).toList();
    }
    map['totalQuantity'] = _totalQuantity;
    map['totalPrice'] = _totalPrice;
    return map;
  }

}

class Items {
  String? _id;
  String? _product;
  int? _totalProductQuantity;
  int? _totalProductPrice;

  String? get id => _id;
  String? get product => _product;
  int? get totalProductQuantity => _totalProductQuantity;
  int? get totalProductPrice => _totalProductPrice;

  Items({
      String? id, 
      String? product,
      int? totalProductQuantity, 
      int? totalProductPrice}){
    _id = id;
    _product = product;
    _totalProductQuantity = totalProductQuantity;
    _totalProductPrice = totalProductPrice;
}

  Items.fromJson(dynamic json) {
    _id = json['_id'];
    _product = json['product'];
    _totalProductQuantity = json['totalProductQuantity'];
    _totalProductPrice = json['totalProductPrice'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['_id'] = _id;
    if (_product != null) {
      map['product'] = _product;
    }
    map['totalProductQuantity'] = _totalProductQuantity;
    map['totalProductPrice'] = _totalProductPrice;
    return map;
  }

}
