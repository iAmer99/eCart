import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecart/core/remote/dio_util.dart';
import 'package:ecart/features/auth/login/repository/model/login_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LoginRepository{
  final Dio _dio;
  LoginRepository(this._dio);

  Future<Either<String, LoginResponse>> login(Map<String, String> map) async {
    try {
      final response = await _dio.post('/auth/login', data: map);
      final data =  LoginResponse.fromJson(response.data);
      return Right(data);
    } on DioError catch (error) {
      final response = LoginResponse.fromJson(error.response!.data);
      if(response.message == null){
        return Left(DioUtil.handleDioError(error));
      }else {
        return Left(response.message!);
      }
    }catch(error){
      debugPrint(error.toString());
      return Left("unknown_error".tr);
    }
  }
}