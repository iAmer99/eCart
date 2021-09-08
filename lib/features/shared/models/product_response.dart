import 'package:ecart/features/shared/models/product.dart';

class ProductResponse {
  String? _type;
  String? _message;
  Product? _product;

  String? get type => _type;
  String? get message => _message;
  Product? get product => _product;

  ProductResponse({
      String? type, 
      String? message, 
      Product? product}){
    _type = type;
    _message = message;
    _product = product;
}

  ProductResponse.fromJson(dynamic json) {
    _type = json['type'];
    _message = json['message'];
    _product = json['product'] != null ? Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['type'] = _type;
    map['message'] = _message;
    if (_product != null) {
      map['product'] = _product?.toJson();
    }
    return map;
  }

}
