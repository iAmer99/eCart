import 'package:dio/dio.dart';
import 'package:ecart/features/product_details/controller/product_controller.dart';
import 'package:ecart/features/product_details/repository/product_repository.dart';
import 'package:get/get.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductController>(() => ProductController(ProductRepository(Get.find<Dio>(tag: 'dio'))));
  }

}