import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecart/core/remote/dio_util.dart';
import 'package:ecart/features/shared/models/category.dart';

class CategoriesRepository {
  final Dio _dio;

  CategoriesRepository(this._dio);

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
}