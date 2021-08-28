
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecart/core/remote/dio_util.dart';
import 'package:ecart/features/auth/register/repository/model/register_response.dart';
import 'package:flutter/material.dart';

class RegisterRepository {
  final Dio _dio;

  RegisterRepository(this._dio);

  Future<Either<String, RegisterResponse>> register(FormData formData) async {
    try {
      final response = await _dio.post('/auth/register', data: formData);
      final res = RegisterResponse.fromJson(response.data);
      return Right(res);
    } on DioError catch (error) {
      final response = error.response!.data as Map<String, dynamic>;
      final res = RegisterResponse.fromJson(response);
      if(res.message == null){
        return Left(DioUtil.handleDioError(error));
      }else {
        return Left(res.message!);
      }
    }catch(error){
      debugPrint(error.toString());
      return Left("Something went wrong!");
    }
  }
}
