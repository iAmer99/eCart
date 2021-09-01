import 'package:dio/dio.dart';
import 'package:ecart/features/more/controller/more_controller.dart';
import 'package:ecart/features/more/repository/more_repository.dart';
import 'package:get/get.dart';

class MoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MoreController>(
        () => MoreController(MoreRepository(Get.find<Dio>(tag: 'dio'))),
        fenix: true);
  }
}
