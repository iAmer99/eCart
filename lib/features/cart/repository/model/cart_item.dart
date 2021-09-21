import 'package:ecart/features/shared/models/product.dart';

class CartItem {
  Product? _product;
  num? _totalProductQuantity;
  num? _totalProductPrice;
  Color? _selectedColor;
  Size? _selectedSize;

  Product? get product => _product;

  num? get totalProductQuantity => _totalProductQuantity;

  num? get totalProductPrice => _totalProductPrice;

  Color? get selectedColor => _selectedColor;

  Size? get selectedSize => _selectedSize;

  set totalProductQuantitySetter(num quantity) => _totalProductQuantity = quantity;
  set totalProductPriceSetter(num price) => _totalProductPrice = price;

  CartItem({
     required Product product,
     required num totalProductQuantity,
     required num totalProductPrice,
    required Color selectedColor,
    required Size selectedSize,
  }) {
    _product = product;
    _totalProductPrice = totalProductPrice;
    _totalProductQuantity = totalProductQuantity;
    _selectedColor = selectedColor;
    _selectedSize = selectedSize;
  }
}
