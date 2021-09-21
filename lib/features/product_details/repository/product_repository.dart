import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecart/core/remote/dio_util.dart';
import 'package:ecart/features/product_details/repository/model/productInCart.dart';
import 'package:ecart/features/shared/models/cart.dart';
import 'package:ecart/features/shared/models/product.dart';
import 'package:ecart/features/shared/models/product_response.dart';

class ProductRepository {
  final Dio _dio;

  ProductRepository(this._dio);

  Future<bool> checkFavourite(String id) async {
    try {
      final response = await _dio.get("favorite/check/$id");
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<Either<String, List<ProductInCart>>> checkCart(String id) async {
    try {
      final response = await _dio.get("/cart");
      final CartResponse data = CartResponse.fromJson(response.data);
      if (data.cart != null) {
        if (data.cart!.items!.any((element) => element.product == id)) {
          List<ProductInCart> list = [];
          List<Items> items =
              data.cart!.items!.where((element) => element.product == id).toList();
          for(var item in items){
            list.add(
              ProductInCart(
                id: "${item.selectedColor!.id}" + "${item.selectedSize!.id}",
                quantity: item.totalProductQuantity!,
                selectedColor: item.selectedColor!,
                selectedSize: item.selectedSize!,
              ),
            );
          }
          return Right(list);
        }
      }
      return Left("Product not in the cart");
    } catch (error) {
      print(error.toString());
      return Left("Product not in the cart");
    }
  }

  Future<Either<String, bool>> addToFavourite(String id) async {
    try {
      final response = await _dio.post('favorite', data: {"productId": id});
      if (response.statusMessage == "OK") {
        return Right(true);
      } else {
        return Left("Something went wrong!");
      }
    } catch (error) {
      if (error is DioError) {
        if (error.response == null) {
          return Left(DioUtil.handleDioError(error));
        } else {
          final res = error.response!.data as Map<String, dynamic>;
          return Left(res["message"]);
        }
      } else {
        print(error.toString());
        return Left("Something went wrong!");
      }
    }
  }

  Future<Either<String, bool>> removeFromFavourites(String id) async {
    try {
      final response = await _dio.delete("favorite/$id");
      if (response.statusMessage == "OK") {
        return Right(true);
      } else {
        return Left("Something went wrong!");
      }
    } catch (error) {
      if (error is DioError) {
        if (error.response == null) {
          return Left(DioUtil.handleDioError(error));
        } else {
          final res = error.response!.data as Map<String, dynamic>;
          return Left(res["message"]);
        }
      } else {
        print(error.toString());
        return Left("Something went wrong!");
      }
    }
  }

  Future<Either<String, bool>> addToCart(String id, int quantity,
      String selectedColorID, String selectedSizeID) async {
    try {
      final response = await _dio.post('cart', data: {
        "productId": id,
        "quantity": quantity,
        "selectedColor": selectedColorID,
        "selectedSize": selectedSizeID,
      });
      if (response.statusMessage == "OK") {
        return Right(true);
      } else {
        return Left("Something went wrong!");
      }
    } catch (error) {
      if (error is DioError) {
        if (error.response == null) {
          return Left(DioUtil.handleDioError(error));
        } else {
          final res = error.response!.data as Map<String, dynamic>;
          return Left(res["message"]);
        }
      } else {
        print(error.toString());
        return Left("Something went wrong!");
      }
    }
  }

  Future<Either<String, bool>> increase(
      String id, String selectedColorID, String selectedSizeID) async {
    try {
      final response = await _dio.patch('cart/increase-one', data: {
        "productId": id,
        "selectedColor": selectedColorID,
        "selectedSize": selectedSizeID,
      });
      if (response.statusMessage == "OK") {
        return Right(true);
      } else {
        return Left("Something went wrong!");
      }
    } catch (error) {
      if (error is DioError) {
        if (error.response == null) {
          return Left(DioUtil.handleDioError(error));
        } else {
          final res = error.response!.data as Map<String, dynamic>;
          return Left(res["message"]);
        }
      } else {
        print(error.toString());
        return Left("Something went wrong!");
      }
    }
  }

  Future<Either<String, bool>> decrease(
      String id, String selectedColorID, String selectedSizeID) async {
    try {
      final response = await _dio.patch('cart/reduce-one', data: {
        "productId": id,
        "selectedColor": selectedColorID,
        "selectedSize": selectedSizeID,
      });
      if (response.statusMessage == "OK") {
        return Right(true);
      } else {
        return Left("Something went wrong!");
      }
    } catch (error) {
      if (error is DioError) {
        if (error.response == null) {
          return Left(DioUtil.handleDioError(error));
        } else {
          final res = error.response!.data as Map<String, dynamic>;
          return Left(res["message"]);
        }
      } else {
        print(error.toString());
        return Left("Something went wrong!");
      }
    }
  }

  Future<Either<String, Product>> refreshProduct(String productID) async {
    try {
      final response = await _dio.get("product/$productID");
      final data = ProductResponse.fromJson(response.data);
      return Right(data.product!);
    } catch (error) {
      if (error is DioError) {
        if (error.response == null) {
          return Left(DioUtil.handleDioError(error));
        } else if (error.response!.statusCode == 404) {
          return Left("No Product found");
        } else {
          final res = error.response!.data as Map<String, dynamic>;
          return Left(res["message"]);
        }
      } else {
        print(error.toString());
        return Left("Something went wrong!");
      }
    }
  }
}
