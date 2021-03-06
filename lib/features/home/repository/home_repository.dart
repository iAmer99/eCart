import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:ecart/core/remote/dio_util.dart';
import 'package:ecart/core/session_management.dart';
import 'package:ecart/features/home/repository/models/refresh_tokens.dart';
import 'package:ecart/features/shared/models/category.dart';
import 'package:ecart/features/shared/models/product.dart';

class HomeRepository {
  final Dio _dio;

  HomeRepository(this._dio);

  Future<Either<String, List<Category>?>> getCategories() async {
    try {
      final response = await _dio.get("category");
      final data = response.data as Map<String , dynamic>;
      List? categoriesData = data["categories"];
      List<Category>? categories = categoriesData?.map((element){
        return Category.fromJson(element);
      }).toList();
      return Right(categories);
    } catch (error) {
      if (error is DioError) {
        if(error.response == null){
          return Left(DioUtil.handleDioError(error));
        }else if(error.response!.statusCode == 404){
          return Right([]);
        }
        else{
          final res = error.response!.data as Map<String, dynamic>;
          return Left(res["message"]);
        }
      } else {
        return Left("Something went wrong!");
      }
    }
  }

  Future<Either<String, List<Product>?>> getProducts(String urlSegment) async{
    try{
      final response = await _dio.get("product$urlSegment");
      final data = response.data as Map<String , dynamic>;
      List? productsData = data["products"];
      List<Product>? products = productsData?.map((map){
        return Product.fromJson(map);
      }).toList();
      return Right(products);
    }catch (error){
      if (error is DioError) {
        if(error.response == null){
          return Left(DioUtil.handleDioError(error));
        }else if(error.response!.statusCode == 404){
          return Right([]);
        }
        else{
          final res = error.response!.data as Map<String, dynamic>;
          return Left(res["message"]);
        }
      } else {
        print(error.toString());
        return Left("unknown_error".tr);
      }
    }
  }

  Future<Either<String, RefreshTokens>> checkTokenValidity() async{
    try{
      final response = await _dio.post("auth/tokens", data: {
        "refreshToken" : SessionManagement.refreshToken
      });
      final data = response.data as Map<String , dynamic>;
      return Right(RefreshTokens.fromJson(data));
    }catch (error){
      if (error is DioError) {
        if(error.response == null){
          return Left(DioUtil.handleDioError(error));
        }else{
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
