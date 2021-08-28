
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecart/core/remote/dio_util.dart';

class ForgotPasswordRepository {
  final Dio _dio;
  ForgotPasswordRepository(this._dio);
  
  Future<Either<String, String>> forgotPassword(Map<String, String> data) async{
   try{
     final response = await _dio.post("auth/forgot-password", data: data);
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

  Future<Either<String, String>> resetPassword(Map<String, String> data, String code) async{
    try{
      final response = await _dio.post("auth/reset-password?token=$code", data: data);
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