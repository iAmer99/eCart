import 'package:dio/dio.dart';
import 'package:ecart/features/favourites/controller/favourite_controller.dart';
import 'package:ecart/features/favourites/repository/favourite_repository.dart';
import 'package:get/get.dart';

class FavouritesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavouritesController>(
        () => FavouritesController(
            FavouritesRepository(Get.find<Dio>(tag: 'dio'))),
        fenix: true);
  }
}
