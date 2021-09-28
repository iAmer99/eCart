import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:ecart/core/remote/dio_util.dart';
import 'package:ecart/features/orders/repository/models/order.dart' as model;
import 'package:ecart/features/orders/repository/models/order_response.dart';

class OrdersRepository {
  final Dio _dio;

  OrdersRepository(this._dio);

  Future<Either<String, List<model.Order>>> getOrders(Map<String, Object> query) async{
    try{
      final response = await _dio.get('order', queryParameters: query);
      final data = OrderResponse.fromJson(response.data);
      if(data.orders != null){
        return Right(data.orders!);
      }else{
        return Right([]);
      }
    }catch (error){
      if (error is DioError) {
        if (error.response == null) {
          return Left(DioUtil.handleDioError(error));
        } else if (error.response!.statusCode == 404) {
          return Right([]);
        } else {
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