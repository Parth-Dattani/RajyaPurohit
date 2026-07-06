import 'package:get/get.dart';
import '../controllers/sanstha_controller.dart';

class SansthaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SansthaController>(() => SansthaController());
  }
}