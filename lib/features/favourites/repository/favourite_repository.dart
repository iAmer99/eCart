import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecart/core/remote/dio_util.dart';
import 'package:ecart/features/shared/models/product.dart';

import 'model/favourite_response.dart';

class FavouritesRepository {
  final Dio _dio;

  FavouritesRepository(this._dio);

  Future<Product> getProduct(String id,) async {
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

  Future<Either<String, List<Product>>> getFavourites() async {
    try {
      final response = await _dio.get('favorite');
      final resData = response.data as Map<String, dynamic>;
      final data = FavouriteResponse.fromJson(resData);
      List<Product> favourites = [];
      for(var id in data.favorite!.products!){
        favourites.add(await getProduct(id));
      }
      return Right(favourites);
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

}
