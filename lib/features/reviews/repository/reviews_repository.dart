import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecart/core/remote/dio_util.dart';
import 'package:ecart/features/shared/models/product_response.dart';
import 'package:ecart/features/reviews/repository/models/reviews_response.dart';
import 'package:ecart/features/shared/models/user_response.dart';
import 'package:ecart/features/shared/models/product.dart';

class ReviewsRepository {
  final Dio _dio;

  ReviewsRepository(this._dio);

  Future<Either<String, List<Map<String, Object>>>> getReviews(
      String productID, int page) async {
    try {
      final response = await _dio
          .get('product/$productID/reviews', queryParameters: {"page": page});
      final data = ReviewsResponse.fromJson(response.data);
      List<Map<String, Object>> dataList = [];
      if (data.review != null) {
        for (var review in data.review!) {
          User user = await getUserData(review.user!);
          dataList.add({
            "review": review,
            "user": user,
          });
        }
      }
      return Right(dataList);
    } catch (error) {
      if (error is DioError) {
        if (error.response == null) {
          return Left(DioUtil.handleDioError(error));
        } else if (error.response!.statusCode == 404) {
          return Right([]);
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

  Future<User> getUserData(String id) async {
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

  Future<Either<String, bool>> deleteReview(
      String productID, String reviewID) async {
    try {
      final response =
          await _dio.delete('product/$productID/reviews/$reviewID');
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

  Future<Either<String, bool>> addReview(
      String productID, Map<String, Object> data) async {
    try {
      final response =
          await _dio.post('product/$productID/reviews', data: data);
      if (response.statusMessage == "Created") {
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

  Future<Either<String, bool>> editReview(
      String productID, String reviewID, Map<String, Object> data) async {
    try {
      final response =
          await _dio.patch('product/$productID/reviews/$reviewID', data: data);
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
