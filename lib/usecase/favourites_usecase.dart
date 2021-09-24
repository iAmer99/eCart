import 'package:dartz/dartz.dart';
import 'package:ecart/core/remote/dio_util.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class FavouritesUseCase {
  static final Dio _dio = Get.find(tag: 'dio');

  static Future<Either<String, bool>> addToFavourite(String id) async {
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

  static Future<Either<String, bool>> removeFromFavourites(String id) async {
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
}