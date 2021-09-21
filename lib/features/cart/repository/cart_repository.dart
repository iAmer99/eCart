import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecart/core/remote/dio_util.dart';
import 'package:ecart/core/session_management.dart';
import 'package:ecart/features/cart/repository/model/cart_item.dart';
import 'package:ecart/features/cart/repository/model/discount_response.dart';
import 'package:ecart/features/shared/models/cart.dart';
import 'package:ecart/features/shared/models/product.dart';
import 'package:ecart/features/shared/models/user_response.dart';

class CartRepository {
  final Dio _dio;

  CartRepository(this._dio);

  Future<Either<String, Cart>> getCartItems() async {
    try {
      final response = await _dio.get('cart');
      final data = CartResponse.fromJson(response.data);
      List<CartItem> cartItems = [];
      for (var item in data.cart!.items!) {
        Product product = await _getProduct(item.product!);
        CartItem cartItem = CartItem(
          product: product,
          totalProductQuantity: item.totalProductQuantity!,
          selectedColor: item.selectedColor!,
          selectedSize: item.selectedSize!,
          totalProductPrice: item.totalProductPrice!,
        );
        cartItems.add(cartItem);
      }
      data.cart!.cartItemsSetter = cartItems;
      return Right(data.cart!);
    } catch (error) {
      if (error is DioError) {
        if (error.response == null) {
          return Left(DioUtil.handleDioError(error));
        } else if (error.response!.statusCode == 404) {
          return Right(Cart(cartItems: []));
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

  Future<Product> _getProduct(
    String id,
  ) async {
    try {
      final response = await _dio.get("product/$id");
      final data = response.data as Map<String, dynamic>;
      Map<String, dynamic>? productData = data["product"];
      Product product = Product.fromJson(productData);
      return product;
    } catch (error) {
      throw error;
    }
  }

  Future<Either<String, bool>> increase(String id, String selectedColorID, String selectedSizeID) async {
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
          print(res);
          return Left(res["message"]);
        }
      } else {
        print(error.toString());
        return Left("Something went wrong!");
      }
    }
  }

  Future<Either<String, bool>> decrease(String id, String selectedColorID, String selectedSizeID) async {
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

  Future<Either<String, bool>> removeFromCart(String id, String selectedColorID, String selectedSizeID) async {
    try {
      final response = await _dio.delete("cart/$id", data: {
        "selectedColor": selectedColorID,
        "selectedSize": selectedSizeID,
      });
      if (response.statusMessage == "OK") {
        return Right(true);
      }
      return Right(false);
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

  Future<Either<String, num>> verifyDiscount(String code) async {
    try {
      final response =
          await _dio.post('discount/verify', data: {"discountCode": code});
      final data = DiscountResponse.fromJson(response.data);
      return Right(data.discount!);
    } catch (error) {
      if (error is DioError) {
        if (error.response == null) {
          return Left(DioUtil.handleDioError(error));
        } else if (error.response!.statusCode == 404) {
          return Left("Invalid Code");
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

  Future<Either<String, bool>> cancelDiscount() async {
    try {
      final response = await _dio.delete("discount/cancel");
      if (response.statusMessage == "OK") {
        return Right(true);
      }
      return Right(false);
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

  Future<Either<String, Discount>> checkDiscount() async {
    try {
      final User user = await _getUserData(SessionManagement.userID!);
      if (user.discountCode != null) {
        final response = await _dio.get("discount/find");
        final data = DiscountResponse.fromJson(response.data);
        return Right(Discount(code: user.discountCode!, off: data.discount!));
      } else {
        return Left("No Discount Found");
      }
    } catch (error) {
      if (error is DioError) {
        if (error.response == null) {
          return Left(DioUtil.handleDioError(error));
        } else if (error.response!.statusCode == 404) {
          return Left("Invalid Code");
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

  Future<User> _getUserData(String id) async {
    try {
      final response = await _dio.get('user/$id');
      final data = UserResponse.fromJson(response.data);
      if (data.user != null) {
        return data.user!;
      } else {
        throw "User not found";
      }
    } catch (error) {
      if (error is DioError) {
        if (error.response == null) {
          throw DioUtil.handleDioError(error);
        } else if (error.response!.statusCode == 404) {
          throw "User not found";
        } else {
          final res = error.response!.data as Map<String, dynamic>;
          throw res["message"];
        }
      } else {
        print(error.toString());
        throw "Something went wrong!";
      }
    }
  }
}
