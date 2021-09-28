import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../session_management.dart';

class DioUtil {
  static DioUtil? _instance;
  static late Dio _dio;

  static BaseOptions options = BaseOptions(
      baseUrl: "https://e-commerce-a-p-i.herokuapp.com/api/",
      receiveDataWhenStatusError: true,
      contentType: Headers.jsonContentType,
      connectTimeout: 50 * 1000,
      receiveTimeout: 50 * 1000,
      headers: {
        'Authorization': "Bearer ${SessionManagement.accessToken}",
        "Accept-Language": SessionManagement.isArabic? "ar_MX" : "en_MX",
      });

  static DioUtil? init() {
    if (_instance == null) {
      _dio = Dio(options);
    }
    // dependency injection
    Get.put<Dio>(_dio, permanent: true, tag: 'dio');

    return _instance;
  }

  static setDioAgain() {
    options.headers = {
      'Authorization': "Bearer ${SessionManagement.accessToken}",
      "Accept-Language": SessionManagement.isArabic? "ar_MX" : "en_MX",
    };
    _dio = Dio(options);
    Get.replace<Dio>(Dio(options), tag: 'dio');
    return _instance;
  }

  static Dio get dio => _dio;

  static String handleDioError(DioError dioError) {
    String errorDescription = "";
    switch (dioError.type) {
      case DioErrorType.cancel:
        errorDescription = "request_cancelled".tr;
        break;
      case DioErrorType.connectTimeout:
        //Connection timeout with API server
        errorDescription = "timeout".tr;
        break;
      case DioErrorType.other:
        errorDescription = "no_internet".tr;
        break;
      case DioErrorType.response:
        errorDescription = "timeout".tr;
        break;
      case DioErrorType.response:
        print("Received invalid status code: ${dioError.response?.statusCode}");
        errorDescription = "unknown_error".tr;
        break;
      case DioErrorType.sendTimeout:
        errorDescription = "timeout".tr;
        break;
    }
    return errorDescription;
  }
}
