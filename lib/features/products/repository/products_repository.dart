import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecart/core/remote/dio_util.dart';
import 'package:ecart/features/shared/models/product.dart';

class ProductsRepository {
  final Dio _dio;

  ProductsRepository(this._dio);

  getCategoryProducts(Map<String, dynamic> query) async{
    try{
      final response = await _dio.get("product", queryParameters: query);
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
        return Left("Something went wrong!");
      }
    }
  }
}