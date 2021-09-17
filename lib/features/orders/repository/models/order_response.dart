import 'package:ecart/features/orders/repository/models/order.dart';

class OrderResponse {
  String? _type;
  String? _message;
  List<Order>? _orders;

  String? get type => _type;
  String? get message => _message;
  List<Order>? get orders => _orders;

  OrderResponse({
      String? type, 
      String? message, 
      List<Order>? orders}){
    _type = type;
    _message = message;
    _orders = orders;
}

  OrderResponse.fromJson(dynamic json) {
    _type = json['type'];
    _message = json['message'];
    if (json['orders'] != null) {
      _orders = [];
      json['orders'].forEach((v) {
        _orders?.add(Order.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['type'] = _type;
    map['message'] = _message;
    if (_orders != null) {
      map['orders'] = _orders?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}
