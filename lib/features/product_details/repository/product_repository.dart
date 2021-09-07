import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecart/core/remote/dio_util.dart';
import 'package:ecart/features/shared/models/cart.dart';

class ProductRepository {
  final Dio _dio;

  ProductRepository(this._dio);

  Future<bool> checkFavourite(String id) async {
    try {
      final response = await _dio.get("/product/favorite/check/$id");
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<Map<String, Object?>> checkCart(String id) async {
    try {
      final response = await _dio.get("/cart");
      final CartResponse data = CartResponse.fromJson(response.data);
      if(data.cart != null) {
        if (data.cart!.items!.any((element) => element.product == id)) {
          return {
            "exists": true,
            "quantity": data.cart!.items!.firstWhere((element) => element.product == id).totalProductQuantity,
          };
        }
      }
      return {
        "exists" : false,
      };
    }catch (_) {
      return {
        "exists" : false,
      };
    }
  }

  Future<Either<String, bool>> addToFavourite(String id) async {
    try {
      final response =
          await _dio.post('/product/favorite', data: {"productId": id});
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
      final response = await _dio.delete("product/favorite/$id");
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

  Future<Either<String, bool>> addToCart(String id, int quantity) async {
    try {
      final response = await _dio.post('cart', data: {
        "productId": id,
        "quantity": quantity,
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

  Future<Either<String, bool>> increase(String id) async{
    try {
      final response = await _dio.patch('cart/increase-one', data: {
        "productId": id,
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

  Future<Either<String, bool>> decrease(String id) async{
    try {
      final response = await _dio.patch('cart/reduce-one', data: {
        "productId": id,
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

}
