import 'package:dio/dio.dart';
import 'package:ecart/features/categories/controller/categories_controller.dart';
import 'package:ecart/features/categories/repository/categories_repository.dart';
import 'package:get/get.dart';

class CategoriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoriesController>(
        () => CategoriesController(
            CategoriesRepository(Get.find<Dio>(tag: 'dio'))),
        fenix: true);
  }
}
