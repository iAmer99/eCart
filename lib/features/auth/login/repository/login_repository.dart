import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecart/core/remote/dio_util.dart';

class LoginRepository{
  final Dio _dio;
  LoginRepository(this._dio);

  Future<Either<String, String>> login(Map<String, String> map) async {
    try {
      final response = await _dio.post('/auth/login', data: map);
      final data = response.data as Map<String, dynamic>;
      return Right(data["message"]);
    } on DioError catch (error) {
      final response = error.response!.data as Map<String, dynamic>;
      if(!response.containsKey("message")){
        return Left(DioUtil.handleDioError(error));
      }else {
        return Left(response["message"]);
      }
    }
  }
}