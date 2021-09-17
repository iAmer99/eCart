import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecart/core/remote/dio_util.dart';
import 'package:ecart/core/session_management.dart';
import 'package:ecart/features/shared/models/user_response.dart';

class AccountRepository {
  final Dio _dio;

  AccountRepository(this._dio);

  Future<Either<String, User>> updateData(Map<String, Object> map) async {
    try {
      final response = await _dio.patch('user/update-details', data: map);
      if (response.statusCode == 200) {
        final User user = await _getUserData(SessionManagement.userID!);
        return Right(user);
      } else {
        return Left("Something went wrong!");
      }
    } catch (error) {
      if (error is DioError) {
        if (error.response == null) {
          return Left(DioUtil.handleDioError(error));
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
  
  Future<Either<String, bool>> updatePicture(FormData formData) async{
    try{
      final response = await _dio.patch('user/update-profile-image', data: formData);
      if (response.statusCode == 200) {
        return Right(true);
      } else {
        return Right(false);
      }
    }catch (error){
      if (error is DioError) {
        if (error.response == null) {
          return Left(DioUtil.handleDioError(error));
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

  Future<User> _getUserData(String id) async {
    try {
      final response = await _dio.get('user/$id');
      final data = UserResponse.fromJson(response.data);
      if (data.user != null) {
        return data.user!;
      } else {
        throw "User not found";
      }
    } catch (error) {
      if (error is DioError) {
        if (error.response == null) {
          throw DioUtil.handleDioError(error);
        } else if (error.response!.statusCode == 404) {
          throw "User not found";
        } else {
          final res = error.response!.data as Map<String, dynamic>;
          throw res["message"];
        }
      } else {
        print(error.toString());
        throw "Something went wrong!";
      }
    }
  }
}
