import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecart/core/remote/dio_util.dart';
import 'package:ecart/core/session_management.dart';
import 'package:ecart/features/favourites/repository/model/favourites_response.dart';
import 'package:ecart/features/shared/models/product.dart';

class FavouritesRepository {
  final Dio _dio;

  FavouritesRepository(this._dio);

  Future<Either<String, Product>> getProduct(String id,) async {
    try {
      final response = await _dio.get("product/$id");
      final data = response.data as Map<String, dynamic>;
      Map<String, dynamic>? productData = data["product"];
      Product product = Product.fromJson(productData);
      return Right(product);
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

  Future<Either<String, List<String>>> getFavourites() async {
    try {
      final response = await _dio.get('product/favorite');
      final resData = response.data as Map<String, dynamic>;
      final data = FavouritesResponse.fromJson(resData);
      return Right(data.products!);
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

  Future<Either<String, bool>> removeFromFavourites(String id) async{
     try{
       final response = await _dio.delete("product/favorite/$id");
       print(response.statusMessage);
       if(response.statusMessage == "OK"){
         return Right(true);
       }else{
         return Left("Something went wrong!");
       }
     } catch (error){
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
