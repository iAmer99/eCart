import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecart/core/remote/dio_util.dart';

class ChangePasswordRepository {
  final Dio _dio;

  ChangePasswordRepository(this._dio);

  Future<Either<String, String>> changePassword(Map<String, String> data) async{
    try{
      final response = await _dio.patch("auth/change-password", data: data);
      final responseData = response.data as Map<String, dynamic>;
      return Right(responseData["message"]);
    } on DioError catch(error){
      final response = error.response!.data as Map<String, dynamic>;
      if(!response.containsKey("message")){
        return Left(DioUtil.handleDioError(error));
      }else {
        return Left(response["message"]);
      }
    }
  }
}