import 'package:ecart/features/shared/models/product.dart';

class CartItem {
  Product? _product;
  num? _totalProductQuantity;
  num? _totalProductPrice;

  Product? get product => _product;

  num? get totalProductQuantity => _totalProductQuantity;

  num? get totalProductPrice => _totalProductPrice;

  set totalProductQuantitySetter(num quantity) => _totalProductQuantity = quantity;
  set totalProductPriceSetter(num price) => _totalProductPrice = price;

  CartItem({
     required Product product,
     required num totalProductQuantity,
     required num totalProductPrice,
  }) {
    _product = product;
    _totalProductPrice = totalProductPrice;
    _totalProductQuantity = totalProductQuantity;
  }
}
