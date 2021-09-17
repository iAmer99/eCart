class Order {
  List<Products>? _products;
  num? _totalPrice;
  bool? _isPaid;
  bool? _isDelivered;
  num? _taxPrice;
  num? _shippingPrice;
  String? _status;
  String? _id;
  String? _user;
  String? _paidAt;
  ShippingAddress? _shippingAddress;
  String? _paymentMethod;
  String? _phone;

  List<Products>? get products => _products;

  num? get totalPrice => _totalPrice;

  bool? get isPaid => _isPaid;

  bool? get isDelivered => _isDelivered;

  num? get taxPrice => _taxPrice;

  num? get shippingPrice => _shippingPrice;

  String? get status => _status;

  String? get id => _id;

  String? get user => _user;

  String? get paidAt => _paidAt;

  ShippingAddress? get shippingAddress => _shippingAddress;

  String? get paymentMethod => _paymentMethod;

  String? get phone => _phone;

  Order(
      {List<Products>? products,
      num? totalPrice,
      bool? isPaid,
      bool? isDelivered,
      num? taxPrice,
      num? shippingPrice,
      String? status,
      String? id,
      String? user,
      String? paidAt,
      ShippingAddress? shippingAddress,
      String? paymentMethod,
      String? phone}) {
    _products = products;
    _totalPrice = totalPrice;
    _isPaid = isPaid;
    _isDelivered = isDelivered;
    _taxPrice = taxPrice;
    _shippingPrice = shippingPrice;
    _status = status;
    _id = id;
    _user = user;
    _paidAt = paidAt;
    _shippingAddress = shippingAddress;
    _paymentMethod = paymentMethod;
    _phone = phone;
  }

  Order.fromJson(dynamic json) {
    if (json['products'] != null) {
      _products = [];
      json['products'].forEach((v) {
        _products?.add(Products.fromJson(v));
      });
    }
    _totalPrice = json['totalPrice'];
    _isPaid = json['isPaid'];
    _isDelivered = json['isDelivered'];
    _taxPrice = json['taxPrice'];
    _shippingPrice = json['shippingPrice'];
    _status = json['status'];
    _id = json['_id'];
    _user = json['user'];
    _paidAt = json['paidAt'];
    _shippingAddress = json['shippingAddress'] != null
        ? ShippingAddress.fromJson(json['shippingAddress'])
        : null;
    _paymentMethod = json['paymentMethod'];
    _phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_products != null) {
      map['products'] = _products?.map((v) => v.toJson()).toList();
    }
    map['totalPrice'] = _totalPrice;
    map['isPaid'] = _isPaid;
    map['isDelivered'] = _isDelivered;
    map['taxPrice'] = _taxPrice;
    map['shippingPrice'] = _shippingPrice;
    map['status'] = _status;
    map['_id'] = _id;
    map['user'] = _user;
    map['paidAt'] = _paidAt;
    if (_shippingAddress != null) {
      map['shippingAddress'] = _shippingAddress?.toJson();
    }
    map['paymentMethod'] = _paymentMethod;
    map['phone'] = _phone;
    return map;
  }
}

class ShippingAddress {
  String? _address;
  String? _city;
  String? _country;
  String? _postalCode;

  String? get address => _address;

  String? get city => _city;

  String? get country => _country;

  String? get postalCode => _postalCode;

  ShippingAddress(
      {String? address, String? city, String? country, String? postalCode}) {
    _address = address;
    _city = city;
    _country = country;
    _postalCode = postalCode;
  }

  ShippingAddress.fromJson(dynamic json) {
    _address = json['address'];
    _city = json['city'];
    _country = json['country'];
    _postalCode = json['postalCode'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['address'] = _address;
    map['city'] = _city;
    map['country'] = _country;
    map['postalCode'] = _postalCode;
    return map;
  }
}

class Products {
  String? _id;
  String? _product;
  num? _totalProductQuantity;
  num? _totalProductPrice;

  String? get id => _id;

  String? get product => _product;

  num? get totalProductQuantity => _totalProductQuantity;

  num? get totalProductPrice => _totalProductPrice;

  Products(
      {String? id,
      String? product,
      num? totalProductQuantity,
      num? totalProductPrice}) {
    _id = id;
    _product = product;
    _totalProductQuantity = totalProductQuantity;
    _totalProductPrice = totalProductPrice;
  }

  Products.fromJson(dynamic json) {
    _id = json['_id'];
    _product = json['product'];
    _totalProductQuantity = json['totalProductQuantity'];
    _totalProductPrice = json['totalProductPrice'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['_id'] = _id;
    map['product'] = _product;
    map['totalProductQuantity'] = _totalProductQuantity;
    map['totalProductPrice'] = _totalProductPrice;
    return map;
  }
}
