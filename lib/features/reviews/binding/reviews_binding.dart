import 'package:dio/dio.dart';
import 'package:ecart/features/reviews/controller/reviews_controller.dart';
import 'package:ecart/features/reviews/repository/reviews_repository.dart';
import 'package:get/get.dart';

class ReviewsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReviewsController>(() => ReviewsController(ReviewsRepository(Get.find<Dio>(tag: 'dio'))));
  }

}