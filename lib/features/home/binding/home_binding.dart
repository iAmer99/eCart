import 'package:dio/dio.dart';
import 'package:ecart/features/home/controller/home_controller.dart';
import 'package:ecart/features/home/repository/home_repository.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(HomeRepository(Get.find<Dio>(tag: "dio"))), fenix: true);
  }

}