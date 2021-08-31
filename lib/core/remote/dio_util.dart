import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../session_management.dart';

class DioUtil{

  static DioUtil? _instance;
  static late Dio _dio;

  static DioUtil? init(){
    if(_instance == null ){
      _dio = Dio(
          BaseOptions(
              baseUrl: "https://e-commerce-a-p-i.herokuapp.com/api/",
              receiveDataWhenStatusError: true,
              contentType: Headers.jsonContentType,
              connectTimeout: 50  * 1000 ,
              receiveTimeout: 50 * 1000,
            headers: {
             'Authorization': "Bearer ${SessionManagement.accessToken}"
            }
          )
      );
    }
    // dependency injection
    Get.put<Dio>(_dio, permanent: true, tag: 'dio');

    return _instance;
  }

  static Dio get dio => _dio;

  static String handleDioError(DioError dioError) {
    String errorDescription = "";
    switch (dioError.type) {
      case DioErrorType.cancel:
        errorDescription = "request cancelled";
        break;
      case DioErrorType.connectTimeout:
      //Connection timeout with API server
        errorDescription = "timeout";
        break;
      case DioErrorType.other:
        errorDescription = "checkout internet";
        break;
      case DioErrorType.response:
        errorDescription = "timeout";
        break;
      case DioErrorType.response:
        print("Received invalid status code: ${dioError.response?.statusCode}");
        errorDescription = "unknown error";
        break;
      case DioErrorType.sendTimeout:
        errorDescription = "timeout";
        break;
    }
    return errorDescription;
  }

}