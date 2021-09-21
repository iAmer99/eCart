
import 'package:ecart/features/shared/models/product.dart';

class ProductInCart{

  // id is SelectedColor ID + SelectedSize ID
  final String id;
  num quantity;
  final Color selectedColor;
  final Size selectedSize;

  ProductInCart({required this.selectedColor, required this.selectedSize, required this.id, required this.quantity});
}