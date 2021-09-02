import 'package:dio/dio.dart';
import 'package:ecart/features/search/controller/search_controller.dart';
import 'package:ecart/features/search/repository/search_repository.dart';
import 'package:get/get.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchController>(() => SearchController(SearchRepository(Get.find<Dio>(tag: 'dio'))));
  }
  
}