import 'package:ecart/features/more/controller/more_controller.dart';
import 'package:get/get.dart';

class MoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MoreController>(() => MoreController(), fenix: true);
  }
}
