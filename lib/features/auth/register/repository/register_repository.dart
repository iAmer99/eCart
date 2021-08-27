
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecart/core/remote/dio_util.dart';

class RegisterRepository {
  final Dio _dio;

  RegisterRepository(this._dio);

  Future<Either<String, String>> register(FormData formData) async {
    try {
      final response = await _dio.post('/auth/register', data: formData);
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
