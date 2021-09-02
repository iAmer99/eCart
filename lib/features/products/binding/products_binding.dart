import 'package:dio/dio.dart';
import 'package:ecart/features/products/controller/products_controller.dart';
import 'package:ecart/features/products/repository/products_repository.dart';
import 'package:get/get.dart';

class ProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductsController>(() => ProductsController(ProductsRepository(Get.find<Dio>(tag: 'dio'))));
  }

}