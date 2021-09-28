import 'package:dartz/dartz.dart';
import 'package:ecart/core/remote/dio_util.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class CartUseCase {
  static final Dio _dio = Get.find(tag: 'dio');

  static Future<Either<String, bool>> addToCart(String id, int quantity,
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
        return Left("unknown_error".tr);
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
        return Left("unknown_error".tr);
      }
    }
  }

  static Future<Either<String, bool>> increase(
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
        return Left("unknown_error".tr);
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
        return Left("unknown_error".tr);
      }
    }
  }

  static Future<Either<String, bool>> decrease(
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
        return Left("unknown_error".tr);
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
        return Left("unknown_error".tr);
      }
    }
  }

  static Future<Either<String, bool>> removeFromCart(
      String id, String selectedColorID, String selectedSizeID) async {
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
        return Left("unknown_error".tr);
      }
    }
  }
}
